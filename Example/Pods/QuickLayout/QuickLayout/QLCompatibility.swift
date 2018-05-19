//
//  QLCompatibility.swift
//  Pods
//
//  Created by Daniel Huri on 5/12/18.
//

import Foundation

#if os(OSX)
import AppKit
public typealias QLView = NSView
public typealias QLPriority = NSLayoutConstraint.Priority
public typealias QLAttribute = NSLayoutConstraint.Attribute
public typealias QLRelation = NSLayoutConstraint.Relation
#else
import UIKit
public typealias QLView = UIView
public typealias QLPriority = UILayoutPriority
public typealias QLAttribute = NSLayoutAttribute
public typealias QLRelation = NSLayoutRelation
#endif
