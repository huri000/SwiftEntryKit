//
//  EKEntryView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/15/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout

class EKEntryView: EKStyleView {
    
    struct Content {
        var view: UIView
        var attributes: EKAttributes
        
        init(view: UIView, attributes: EKAttributes) {
            self.view = view
            self.attributes = attributes
        }
    }
    
    // MARK: Props
    
    var content: Content! {
        didSet {
            contentView = content.view
        }
    }
    
    var attributes: EKAttributes {
        return content.attributes
    }
    
    private let contentContainerView = EKStyleView()
    private var contentView: UIView! {
        didSet {
            oldValue?.removeFromSuperview()
            
            addSubview(contentContainerView)
            contentContainerView.layoutToSuperview(axis: .vertically)
            contentContainerView.layoutToSuperview(axis: .horizontally)
            contentContainerView.clipsToBounds = true
            
            contentContainerView.addSubview(contentView)
            contentView.layoutToSuperview(axis: .vertically)
            contentView.layoutToSuperview(axis: .horizontally)
                        
            applyDropShadow()

            applyBackgroundToContentView()
            
            applyFrameStyle()
        }
    }

    // MARK: Setup
    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyFrameStyle()
    }
    
    // Apply round corners
    private func applyFrameStyle() {
        guard !appliedStyle else {
            return
        }
        contentContainerView.applyFrameStyle(roundCorners: attributes.roundCorners, border: attributes.border)
    }
    
    // Apply drop shadow
    private func applyDropShadow() {
        switch attributes.shadow {
        case .active(with: let value):
            applyDropShadow(withOffset: value.offset, opacity: value.opacity, radius: value.radius, color: value.color)
        case .none:
            removeDropShadow()
        }
    }

    // Apply background
    private func applyBackgroundToContentView() {
        
        let attributes = content.attributes
        
        let backgroundView = EKBackgroundView()
        backgroundView.background = attributes.entryBackground
        
        switch attributes.positionConstraints.safeArea {
        case .empty(fillSafeArea: let fillSafeArea) where fillSafeArea:
            insertSubview(backgroundView, at: 0)
            backgroundView.layoutToSuperview(axis: .horizontally)
            
            var topInset: CGFloat = 0
            var bottomInset: CGFloat = 0
            switch attributes.position {
            case .top:
                topInset = -EKWindowProvider.safeAreaInsets.top
            case .bottom, .center:
                bottomInset = EKWindowProvider.safeAreaInsets.bottom
            }
            
            backgroundView.layoutToSuperview(.top, offset: topInset)
            backgroundView.layoutToSuperview(.bottom, offset: bottomInset)
            
            if attributes.position.isBottom {
                applyFrameStyle(roundCorners: attributes.roundCorners, border: attributes.border)
            }

        default:
            contentView.insertSubview(backgroundView, at: 0)
            backgroundView.fillSuperview()
        }
    }
}
