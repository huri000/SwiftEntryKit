//
//  EKBackgroundView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class EKBackgroundView: UIView {

    // MARK: Props
    private let visualEffectView: UIVisualEffectView
    private let imageView: UIImageView
    
    // MARK: Setup
    init() {
        imageView = UIImageView()
        visualEffectView = UIVisualEffectView(effect: nil)

        super.init(frame: UIScreen.main.bounds)
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.fillSuperview()
        
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Background setter
    var background: EKAttributes.BackgroundStyle! {
        didSet {
            guard let background = background else {
                return
            }
            
            var backgroundEffect: UIBlurEffect?
            var backgroundColor: UIColor = .clear
            var backgroundImage: UIImage?
            
            switch background {
            case .color(color: let color):
                backgroundColor = color
            case .image(image: let image):
                backgroundImage = image
            case .visualEffect(style: let style):
                backgroundEffect = UIBlurEffect(style: style)
            case .none:
                break
            }
        
            visualEffectView.effect = backgroundEffect
            self.layer.backgroundColor = backgroundColor.cgColor
            imageView.image = backgroundImage
        }
    }
}
