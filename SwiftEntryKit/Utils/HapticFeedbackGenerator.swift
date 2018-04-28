//
//  HapticFeedbackGenerator.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation

struct HapticFeedbackGenerator {
    @available(iOS 10.0, *)
    static func notification(type: UINotificationFeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)        
    }
}
