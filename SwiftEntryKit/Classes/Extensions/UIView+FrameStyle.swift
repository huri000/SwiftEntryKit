//
//  UIView+FrameStyle.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/24/18.
//

import Foundation

extension UIRectCorner {
    static let top: UIRectCorner = [.topLeft, .topRight]
    static let bottom: UIRectCorner = [.bottomLeft, .bottomRight]
    static let none: UIRectCorner = []
}

extension UIView {
//    func applyFrameStyle(roundCorners: EKAttributes.RoundCorners, border: EKAttributes.Border) {
//        var cornerRadius: CGFloat = 0
//        var corners: UIRectCorner = []
//        (corners, cornerRadius) = roundCorners.cornerValues ?? ([], 0)
//        
//        let size = CGSize(width: cornerRadius, height: cornerRadius)
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        layer.mask = maskLayer
//        
//        return;
//
//        if let borderValues = border.borderValues {
//            let borderLayer = CAShapeLayer()
//            borderLayer.path = maskLayer.path
//            borderLayer.fillColor = UIColor.clear.cgColor
//            borderLayer.strokeColor = borderValues.color.cgColor
//            borderLayer.lineWidth = borderValues.width
//            borderLayer.frame = bounds
//            borderLayer.shouldRasterize = true
//            borderLayer.rasterizationScale = UIScreen.main.scale
//            layer.addSublayer(borderLayer)
//        }
//    }
}
