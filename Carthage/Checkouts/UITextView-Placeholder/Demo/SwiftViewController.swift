//
//  SwiftViewController.swift
//  UITextView+Placeholder
//
//  Created by Yoshiyuki Kawashima on 2017/05/15.
//  Copyright © 2017年 Suyeol Jeon. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView: UITextView = UITextView()
        textView.frame = CGRect.init(x: 0, y: 20, width: view.frame.width, height: view.frame.height)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.placeholder = "Are you sure you don\'t want to reconsider? Could you tell us why you wish to leave StyleShare? Your opinion helps us improve StyleShare into a better place for fashionistas from all around the world. We are always listening to our users. Help us improve!"
        view.addSubview(textView)
    }
}
