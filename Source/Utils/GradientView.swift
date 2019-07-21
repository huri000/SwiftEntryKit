//
//  GradientView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    struct Style {
        let gradient: EKAttributes.BackgroundStyle.Gradient
        let displayMode: EKAttributes.DisplayMode
        
        init?(gradient: EKAttributes.BackgroundStyle.Gradient?,
              displayMode: EKAttributes.DisplayMode) {
            guard let gradient = gradient else {
                return nil
            }
            self.gradient = gradient
            self.displayMode = displayMode
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    var style: Style? {
        didSet {
            setupColor()
        }
    }
    
    init() {
        super.init(frame: .zero)
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupColor() {
        guard let style = style else {
            return
        }
        gradientLayer.colors = style.gradient.colors.map {
            $0.color(for: traitCollection, mode: style.displayMode).cgColor
        }
        gradientLayer.startPoint = style.gradient.startPoint
        gradientLayer.endPoint = style.gradient.endPoint
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupColor()
    }
}
