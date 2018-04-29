//
//  CGRect.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/28/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
