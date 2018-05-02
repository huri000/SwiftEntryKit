//
//  EKStyleView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/28/18.
//

class EKStyleView: UIView {
    
    private lazy var borderLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    
    var appliedStyle = false
    
    func applyFrameStyle(roundCorners: EKAttributes.RoundCorners, border: EKAttributes.Border) {
        var cornerRadius: CGFloat = 0
        var corners: UIRectCorner = []
        (corners, cornerRadius) = roundCorners.cornerValues ?? ([], 0)
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        if let borderValues = border.borderValues {
            borderLayer.path = maskLayer.path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = borderValues.color.cgColor
            borderLayer.lineWidth = borderValues.width
            borderLayer.frame = bounds
            layer.addSublayer(borderLayer)
        }
        
        appliedStyle = true
    }
}
