//
//  EKAttributes+HapticFeedback.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/1/18.
//

import Foundation

public extension EKAttributes {
    
    /** Notification haptic feedback type. Adds an additional sensuous layer. Read more at UINotificationFeedbackType. Available from iOS 10, but you are not required to check the iOS version before using it. It's automatically handled by the kit.
     */
    public enum NotificationHapticFeedback {
        case success
        case warning
        case error
        case none
        
        @available(iOS 10.0, *)
        var value: UINotificationFeedbackGenerator.FeedbackType? {
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
