//
//  EKStyleView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/28/18.
//

import UIKit

class EKStyleView: UIView {
    
    private lazy var borderLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    
    private var roundCorners: EKAttributes.RoundCorners!
    private var border: EKAttributes.Border!
    
    var appliedStyle = false
    
    func applyFrameStyle(roundCorners: EKAttributes.RoundCorners, border: EKAttributes.Border) {
        self.roundCorners = roundCorners
        self.border = border
        
        var cornerRadius: CGFloat = 0
        var corners: UIRectCorner = []
        (corners, cornerRadius) = roundCorners.cornerValues ?? ([], 0)
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        
        if !corners.isEmpty && cornerRadius > 0 {
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            layer.mask = maskLayer
        }
        
        if let borderValues = border.borderValues {
            borderLayer.path = path.cgPath
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = borderValues.color.cgColor
            borderLayer.lineWidth = borderValues.width
            borderLayer.frame = bounds
            layer.addSublayer(borderLayer)
        }
        
        appliedStyle = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let roundCorners = roundCorners, let border = border else {
            return
        }
        applyFrameStyle(roundCorners: roundCorners, border: border)
    }
}
