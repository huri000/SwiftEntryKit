//
//  EKRatingSymbolView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 6/1/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

final public class EKRatingSymbolView: UIView {
    
    private let button = UIButton()
    private let imageView = UIImageView()
    
    private let unselectedImage: EKProperty.ImageContent
    private let selectedImage: EKProperty.ImageContent
    
    var selection: EKRatingMessage.Selection
    
    public var isSelected: Bool {
        set {
            imageView.imageContent = newValue ? selectedImage : unselectedImage
        }
        get {
            return imageView.image == selectedImage.images.first
        }
    }
    
    public init(unselectedImage: EKProperty.ImageContent, selectedImage: EKProperty.ImageContent, selection: @escaping EKRatingMessage.Selection) {
        self.unselectedImage = unselectedImage
        self.selectedImage = selectedImage
        self.selection = selection
        super.init(frame: .zero)
        setupImageView()
        setupButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
