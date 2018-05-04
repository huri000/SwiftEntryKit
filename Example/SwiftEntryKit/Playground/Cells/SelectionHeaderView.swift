//
//  SelectionHeaderView.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/26/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class SelectionHeaderView: UITableViewHeaderFooterView {

    var text: String {
        set {
            textLabel?.text = newValue
        }
        get {
            return textLabel?.text ?? ""
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundView = UIView()
        backgroundView?.backgroundColor = EKColor.BlueGray.c50.withAlphaComponent(0.95)
        textLabel?.font = MainFont.bold.with(size: 17)
        textLabel?.textColor = EKColor.BlueGray.c900
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
