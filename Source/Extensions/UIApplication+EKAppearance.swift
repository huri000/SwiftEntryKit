//
//  UIApplication+EKAppearance.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

extension UIApplication {
    
    func set(statusBarStyle: EKAttributes.StatusBar) {
        let appearance = statusBarStyle.appearance
        UIApplication.shared.isStatusBarHidden = !appearance.visible
        UIApplication.shared.statusBarStyle = appearance.style
    }
}
