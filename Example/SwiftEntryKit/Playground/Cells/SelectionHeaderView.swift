//
//  SelectionHeaderView.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/26/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

final class SelectionHeaderView: UITableViewHeaderFooterView {

    var text: String {
        set {
            textLabel?.text = newValue
        }
        get {
            return textLabel?.text ?? ""
        }
    }
    
    var displayMode = EKAttributes.DisplayMode.inferred {
        didSet {
            setupInterfaceStyle()
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundView = UIView()
        textLabel?.font = MainFont.bold.with(size: 17)
        setupInterfaceStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInterfaceStyle() {
        backgroundView?.backgroundColor = EKColor.headerBackground.color(
            for: traitCollection,
            mode: PresetsDataSource.displayMode
        )
        textLabel?.textColor = EKColor.standardContent.with(alpha: 0.8).color(
            for: traitCollection,
            mode: PresetsDataSource.displayMode
        )
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}
