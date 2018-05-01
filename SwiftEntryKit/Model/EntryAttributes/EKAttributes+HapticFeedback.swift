//
//  EKAttributes+HapticFeedback.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/1/18.
//

import Foundation

public extension EKAttributes {
    
    public enum NotificationHapticFeedback {
        
        case success
        case warning
        case error
        case none
        
        @available(iOS 10.0, *)
        var value: UINotificationFeedbackType? {
            switch self {
            case .success:
                return .success
            case .warning:
                return .warning
            case .error:
                return .error
            case .none:
                return nil
            }
        }
        
        var isValid: Bool {
            return self != .none
        }
    }
}
