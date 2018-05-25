//
//  UIApplication+EKAppearance.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension UIApplication {
    
    func set(statusBarStyle: EKAttributes.StatusBar) {
        let appearance = statusBarStyle.appearance
        UIApplication.shared.isStatusBarHidden = !appearance.visible
        UIApplication.shared.statusBarStyle = appearance.style
    }
}
