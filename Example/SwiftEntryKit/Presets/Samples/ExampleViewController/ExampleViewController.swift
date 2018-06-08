//
//  ExampleViewController.swift
//  SwiftEntryKitDemo
//
//  Created by Daniel Huri on 6/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    private let injectedView: UIView
    
    init(with view: UIView) {
        injectedView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = injectedView
    }
}
