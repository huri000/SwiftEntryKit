//
//  GradientLayer.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/24/18.
//

import UIKit

class GradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    var gradient: EKAttributes.BackgroundStyle.Gradient? {
        didSet {
            gradientLayer.colors = gradient?.colors.map { $0.cgColor }
            gradientLayer.startPoint = gradient?.startPoint ?? .zero
            gradientLayer.endPoint = gradient?.endPoint ?? .zero
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
}
