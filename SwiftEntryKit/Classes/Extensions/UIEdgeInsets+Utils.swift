//
//  UIEdgeInsets.swift
//  FBSnapshotTestCase
//
//  Created by Daniel Huri on 4/21/18.
//

import UIKit

extension UIEdgeInsets {
    var hasVerticalInsets: Bool {
        return top > 0 || bottom > 0
    }
}
