//
//  HapticFeedbackGenerator.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/23/18.
//

import Foundation

struct HapticFeedbackGenerator {
    @available(iOS 10.0, *)
    static func notification(type: UINotificationFeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)        
    }
}
