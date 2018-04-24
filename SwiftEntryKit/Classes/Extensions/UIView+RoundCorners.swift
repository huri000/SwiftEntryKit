//
//  UIView+RoundCorners.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/24/18.
//

import Foundation

public extension UIRectCorner {
    public static let top: UIRectCorner = [.topLeft, .topRight]
    public static let bottom: UIRectCorner = [.bottomLeft, .bottomRight]
}

extension UIView {
    func roundCorners(by value: UIRectCorner, radius: CGFloat) {
        let size = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: value, cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
