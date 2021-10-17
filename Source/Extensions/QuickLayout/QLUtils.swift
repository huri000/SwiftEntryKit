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
public typealias QLMultipleConstraints = [QLAttribute: NSLayoutConstraint]

/**
 Extends layout priority to other readable types
 */
public extension QLPriority {
    static let must = QLPriority(rawValue: 999)
    static let zero = QLPriority(rawValue: 0)
}

/**
 Represents pair of attributes
 */
public struct QLAttributePair {
    public let first: QLAttribute
    public let second: QLAttribute
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
    
    public let horizontal: QLPriority
    public let vertical: QLPriority
    public static var required: QLPriorityPair {
        return QLPriorityPair(.required, .required)
    }
    
    public static var must: QLPriorityPair {
        return QLPriorityPair(.must, .must)
    }
    
    public init(_ horizontal: QLPriority, _ vertical: QLPriority) {
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
        
        let first: QLAttribute
        let second: QLAttribute
        
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
