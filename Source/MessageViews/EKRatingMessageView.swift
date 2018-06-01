//
//  EKRatingMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 6/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import QuickLayout

public struct EKRatingItemContent {
    public var title: EKProperty.LabelContent
    public var description: EKProperty.LabelContent
    public var unselectedImage: EKProperty.ImageContent
    public var selectedImage: EKProperty.ImageContent
    
    public init(title: EKProperty.LabelContent, description: EKProperty.LabelContent, unselectedImage: EKProperty.ImageContent, selectedImage: EKProperty.ImageContent) {
        self.title = title
        self.description = description
        self.unselectedImage = unselectedImage
        self.selectedImage = selectedImage
    }
}

class EKRateSymbolView: UIView {
    
    typealias Selection = (Int) -> Void
    
    private let button = UIButton()
    private let imageView = UIImageView()
    
    private let unselectedImage: EKProperty.ImageContent
    private let selectedImage: EKProperty.ImageContent
    
    var selection: Selection
    
    var isSelected: Bool {
        set {
            imageView.imageContent = newValue ? selectedImage : unselectedImage
        }
        get {
            return imageView.image == selectedImage.image
        }
    }
    
    init(unselectedImage: EKProperty.ImageContent, selectedImage: EKProperty.ImageContent, selection: @escaping Selection) {
        self.unselectedImage = unselectedImage
        self.selectedImage = selectedImage
        self.selection = selection
        super.init(frame: .zero)
        setupImageView()
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        addSubview(button)
        button.fillSuperview()
        button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown), for: [.touchDown])
        button.addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.imageContent = unselectedImage
        imageView.centerInSuperview()
        imageView.sizeToSuperview(withRatio: 0.7)
    }
    
    @objc func touchUpInside() {
        selection(tag)
    }
    
    @objc func touchDown() {
        transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
    }
    
    @objc func touchUp() {
        transform = CGAffineTransform(scaleX: 1, y: 1)
    }
}

class EKSymbolsView: UIView {
    
    private var selectedIndex: Int!
    private var symbolsArray: [EKRateSymbolView] = []
    
    func setup(withRatingItems items: [EKRatingItemContent], selectedIndex: Int? = nil, selection: @escaping EKRateSymbolView.Selection) {
        
        self.selectedIndex = selectedIndex
        
        let internalSelection = { [unowned self] (index: Int) in
            self.select(index: index)
            selection(index)
        }
        
        for (index, item) in items.enumerated() {
            let itemView = EKRateSymbolView(unselectedImage: item.unselectedImage, selectedImage: item.selectedImage, selection: internalSelection)
            itemView.tag = index
            addSubview(itemView)
            itemView.set(.width, .height, of: 50)
            symbolsArray.append(itemView)
        }
        symbolsArray.layoutToSuperview(axis: .vertically)
        symbolsArray.spread(.horizontally, stretchEdgesToSuperview: true)
            
        select(index: selectedIndex)
    }
    
    private func select(index: Int? = nil) {
        var delay: TimeInterval = 0
        for (i, view) in symbolsArray.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if let index = index, i <= index {
                    view.isSelected = true
                    view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                } else if view.isSelected || index == nil {
                    view.isSelected = false
                    view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                    view.transform = .identity
                }, completion: nil)
            }
            delay += 0.05
        }
    }
}

public class EKRatingMessageView: UIView {
    
    private let ratingItems: [EKRatingItemContent]
    private let initialTitle: EKProperty.LabelContent
    private let initialDescription: EKProperty.LabelContent
    private let buttonBarContent: EKProperty.ButtonBarContent
    
    public private(set) var selectedIndex: Int! {
        didSet {
            let item = ratingItems[selectedIndex]
            set(title: item.title, description: item.description)
        }
    }
    
    private let messageContentView = EKMessageContentView()
    private let symbolsView = EKSymbolsView()
    private var buttonBarView: EKButtonBarView!

    public init(initialTitle: EKProperty.LabelContent, initialDescription: EKProperty.LabelContent, ratingItems: [EKRatingItemContent], buttonBarContent: EKProperty.ButtonBarContent) {
        self.ratingItems = ratingItems
        self.initialTitle = initialTitle
        self.initialDescription = initialDescription
        self.buttonBarContent = buttonBarContent
        super.init(frame: .zero)
        setupMessageContentView()
        setupSymbolsView()
        setupButtonBarView(with: buttonBarContent)
        set(title: initialTitle, description: initialDescription)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set(title: EKProperty.LabelContent, description: EKProperty.LabelContent) {
        self.messageContentView.titleContent = title
        self.messageContentView.subtitleContent = description
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.transitionCrossDissolve], animations: {
            SwiftEntryKit.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupMessageContentView() {
        addSubview(messageContentView)
        messageContentView.verticalMargins = 20
        messageContentView.horizontalMargins = 30
        messageContentView.layoutToSuperview(axis: .horizontally)
        messageContentView.layoutToSuperview(.top, offset: 10)
    }
    
    private func setupSymbolsView() {
        addSubview(symbolsView)
        symbolsView.setup(withRatingItems: ratingItems, selectedIndex: selectedIndex) { [unowned self] (index: Int) in
            self.selectedIndex = index
            self.animateIn()
        }
        symbolsView.layoutToSuperview(.centerX)
        symbolsView.layout(.top, to: .bottom, of: messageContentView, offset: 10)
    }

    private func setupButtonBarView(with content: EKProperty.ButtonBarContent) {
        buttonBarView = EKButtonBarView(with: content)
        buttonBarView.clipsToBounds = true
        addSubview(buttonBarView)
        buttonBarView.layout(.top, to: .bottom, of: symbolsView, offset: 30)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.layoutToSuperview(axis: .horizontally)
    }
    
    // MARK: Internal Animation
    private func animateIn() {
        layoutIfNeeded()
        buttonBarView.alpha = 1
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction, .layoutSubviews], animations: {
            
            // Expand
            self.buttonBarView.expand()
            
            /* NOTE: Calling layoutIfNeeded for the whole view hierarchy.
             Sometimes it's easier to just use frames instead of AutoLayout for
             hierarch complexity considerations. Here the animation influences almost the
             entire view hierarchy. */
            SwiftEntryKit.layoutIfNeeded()
            
        }, completion: nil)
    }
}
