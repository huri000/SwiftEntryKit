//
//  ExampleNavigationViewController.swift
//  SwiftEntryKitDemo
//
//  Created by Daniel Huri on 3/15/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ExampleNavigationViewController: UINavigationController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        navigationBar.tintColor = EKColor.navigationItemColor.color(for: traitCollection, mode: .inferred)
    }
}
