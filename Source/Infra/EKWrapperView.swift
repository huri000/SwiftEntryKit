//
//  EKWrapperView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class EKWrapperView: UIView {
    var isAbleToReceiveTouches = false
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isAbleToReceiveTouches {
            return super.hitTest(point, with: event)
        }
        if let view = super.hitTest(point, with: event), view != self {
            return view
        }
        return nil
    }
}

