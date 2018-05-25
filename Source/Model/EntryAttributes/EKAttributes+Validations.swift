//
//  EKAttributes+Validations.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/18/18.
//

import Foundation

extension EKAttributes {
    
    private static var minDisplayDuration: DisplayDuration {
        return 0
    }
    
    var validateDisplayDuration: Bool {
        guard displayDuration >= EKAttributes.minDisplayDuration else {
            return false
        }
        return true
    }
    
    var validateWindowLevel: Bool {
        return windowLevel.value >= UIWindowLevelNormal
    }
    
    var isValid: Bool {
        return validateDisplayDuration && validateWindowLevel
    }
}
