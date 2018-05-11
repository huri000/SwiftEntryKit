//
//  QLUtils.swift
//  QuickLayout
//
//  Created by Daniel Huri on 11/21/17.
//

import Foundation
import UIKit

/**
 Typealias for dictionary that contains multiple constraints
 */
public typealias QLMultipleConstraints = [NSLayoutAttribute : NSLayoutConstraint]

/**
 Extends layout priority to other readable types
 */
public extension UILayoutPriority {
    public static let must = UILayoutPriority(rawValue: 999)
    public static let zero = UILayoutPriority(rawValue: 0)
}

/**
 Represents pair of attributes
 */
public struct QLAttributePair {
    public let first: NSLayoutAttribute
    public let second: NSLayoutAttribute
}

/**
 Represents size constraints
 */
public struct QLSizeConstraints {
    public let width: NSLayoutConstraint
    public let height: NSLayoutConstraint
}

/**
 Represents center constraints
 */
public struct QLCenterConstraints {
    public let x: NSLayoutConstraint
    public let y: NSLayoutConstraint
}

/**
 Represents axis constraints (might be .top and .bottom, .left and .right, .leading and .trailing)
 */
public struct QLAxisConstraints {
    public let first: NSLayoutConstraint
    public let second: NSLayoutConstraint
}

/**
 Represents center and size constraints
 */
public struct QLFillConstraints {
    public let center: QLCenterConstraints
    public let size: QLSizeConstraints
}

/**
 Represents pair of priorities
 */
public struct QLPriorityPair {
    public let horizontal: UILayoutPriority
    public let vertical: UILayoutPriority
    public static var required: QLPriorityPair {
        return QLPriorityPair(.required, .required)
    }
    public static var must: QLPriorityPair {
        return QLPriorityPair(.must, .must)
    }
    public init(_ horizontal: UILayoutPriority, _ vertical: UILayoutPriority) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

/**
 Represents axis description
 */
public enum QLAxis {
    case horizontally
    case vertically
    public var attributes: QLAttributePair {
        let first: NSLayoutAttribute
        let second: NSLayoutAttribute
        switch self {
        case .horizontally:
            first = .left
            second = .right
        case .vertically:
            first = .top
            second = .bottom
        }
        return QLAttributePair(first: first, second: second)
    }
}
