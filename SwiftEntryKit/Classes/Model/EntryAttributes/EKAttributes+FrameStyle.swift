//
//  EKAttributes+FrameStyle.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/28/18.
//

import Foundation

extension EKAttributes {
    
    /** Corner radius of the entry - Specifies the corners */
    public enum RoundCorners {
        case none
        case all(radius: CGFloat)
        case top(radius: CGFloat)
        case bottom(radius: CGFloat)
        
        public var hasRoundCorners: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
        
        public var cornerValues: (value: UIRectCorner, radius: CGFloat)? {
            switch self {
            case .all(radius: let radius):
                return (value: .allCorners, radius: radius)
            case .top(radius: let radius):
                return (value: .top, radius: radius)
            case .bottom(radius: let radius):
                return (value: .bottom, radius: radius)
            case .none:
                return nil
            }
        }
    }
    
    /** Border of the entry */
    public enum Border {
        case none
        case value(color: UIColor, width: CGFloat)
        
        public var hasBorder: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
        
        public var borderValues: (color: UIColor, width: CGFloat)? {
            switch self {
            case .value(color: let color, width: let width):
                return(color: color, width: width)
            case .none:
                return nil
            }
        }
    }
}
