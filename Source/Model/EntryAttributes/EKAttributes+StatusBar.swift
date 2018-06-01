//
//  EKAttributes+StatusBar.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    /** Status bar appearance */
    public enum StatusBar {
        
        /** The appearance of the status bar */
        public typealias Appearance = (visible: Bool, style: UIStatusBarStyle)
        
        /** Hidden. Doesn't apply to iPhone X */
        case hidden
        
        /** Visible with explicit dark style */
        case dark
        
        /** Visible with explicit light style */
        case light
        
        /** Keep previous state of status bar.
         In case there is an already displayed entry, keep its status bar appearance.
         In case the app is already displaying a status bar, keep its appearance */
        case inferred
        
        /** Returns the status bar appearance.
         Note: See *Appearance* */
        public var appearance: Appearance {
            switch self {
            case .dark:
                return (true, .default)
            case .light:
                return (true, .lightContent)
            case .inferred:
                return StatusBar.currentAppearance
            case .hidden:
                return (false, StatusBar.currentStyle)
            }
        }
        
        /** Returns the status bar according to a given appearance */
        public static func statusBar(by appearance: Appearance) -> StatusBar {
            guard appearance.visible else {
                return .hidden
            }
            switch appearance.style {
            case .lightContent:
                return .light
            default:
                return .dark
            }
        }
        
        /** Returns the current appearance */
        public static var currentAppearance: Appearance {
            return (StatusBar.isCurrentVisible, StatusBar.currentStyle)
        }
        
        /** Returns the current status bar */
        public static var currentStatusBar: StatusBar {
            return statusBar(by: currentAppearance)
        }
        
        // Accessors
        private static var currentStyle: UIStatusBarStyle {
            return UIApplication.shared.statusBarStyle
        }
        
        private static var isCurrentVisible: Bool {
            return !UIApplication.shared.isStatusBarHidden
        }
    }
}
