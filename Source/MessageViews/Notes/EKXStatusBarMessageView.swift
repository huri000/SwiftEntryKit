//
//  EKXStatusBarMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout

public class EKXStatusBarMessageView: UIView {
    
    // MARK: Props
    private let leadingLabel = UILabel()
    private let trailingLabel = UILabel()
    
    // MARK: Setup
    public init(leading: EKProperty.LabelContent, trailing: EKProperty.LabelContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(leading: leading, trailing: trailing)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(leading: EKProperty.LabelContent, trailing: EKProperty.LabelContent) {
        clipsToBounds = true
        
        set(.height, of: UIApplication.shared.statusBarFrame.maxY)
        
        addSubview(leadingLabel)
        leadingLabel.content = leading
        
        leadingLabel.layoutToSuperview(axis: .vertically)
        leadingLabel.layoutToSuperview(.leading)
        leadingLabel.layoutToSuperview(.width, ratio: 0.26)
        
        addSubview(trailingLabel)
        trailingLabel.content = trailing
        
        trailingLabel.layoutToSuperview(axis: .vertically)
        trailingLabel.layoutToSuperview(.trailing)
        trailingLabel.layoutToSuperview(.width, ratio: 0.26)
    }
}
