//
//  DescriptionViewController.swift
//  SwiftEntryKitDemo
//
//  Created by Daniel Huri on 3/15/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEntryKit

class DescriptionViewController: UIViewController {

    private let screenTitle: String
    @IBOutlet private var label: UILabel!
    
    init(screenTitle: String) {
        self.screenTitle = screenTitle
        super.init(nibName: type(of: self).className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = screenTitle
        setupColors()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupColors()
    }
    
    private func setupColors() {
        view.backgroundColor = EKColor.standardBackground.color(
            for: traitCollection,
            mode: .inferred
        )
        label.textColor = EKColor.standardContent.color(
            for: traitCollection,
            mode: .inferred
        )
    }
}
