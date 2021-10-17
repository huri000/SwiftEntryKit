//
//  QLViewArray+QuickLayout.swift
//  QuickLayout
//
//  Created by Daniel Huri on 11/20/17.
//

import Foundation
import UIKit

// MARK: Multiple Views in Array
public extension Array where Element: QLView {
    
    /**
     All elements in the collection recieve constant value for the given edge.
     - parameter edge: Should be used with *.width* or *.height*.
     - parameter value: The size of the edge.
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: The instance of the constraint that was applied (discardable).
     */
    @discardableResult
    func set(_ edge: QLAttribute, of value: CGFloat,
             priority: QLPriority = .required) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        for view in self {
            let constraint = view.set(edge, of: value)
            constraints.append(constraint)
        }
        return constraints
    }
    
    /**
     All elements in the collection recieve constant value for the given edges, using variadic parameter.
     - parameter edges: Should be used with *.width* or *.height*.
     - parameter value: The size of the edge.
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: The instance of the constraint that was applied (discardable).
     */
    @discardableResult
    func set(_ edges: QLAttribute..., of value: CGFloat,
             priority: QLPriority = .required) -> [QLMultipleConstraints] {
        var constraintsArray: [QLMultipleConstraints] = []
        for view in self {
            let constraints = view.set(edges, to: value, priority: priority)
            constraintsArray.append(constraints)
        }
        return constraintsArray
    }
    
    /**
     Spread elements consecutively according to the given axis.
     - parameter axis: The axis: *.vertically*, *horizontally*
     - parameter stretchEdgesToSuperview: Decides whether the first and last items in the array must be clipped to their parent edges.
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: Array of constraints that were applied (discardable)
     */
    @discardableResult
    func spread(_ axis: QLAxis, stretchEdgesToSuperview: Bool = false, offset: CGFloat = 0,
                priority: QLPriority = .required) -> [NSLayoutConstraint] {
        guard isValidForQuickLayout else {
            return []
        }
        let attributes = axis.attributes
        var constraints: [NSLayoutConstraint] = []
        
        if stretchEdgesToSuperview {
            let constraint = first!.layoutToSuperview(attributes.first, offset: offset)!
            constraints.append(constraint)
        }
        
        for (index, view) in enumerated() {
            guard index > 0 else {
                continue
            }
            let previousView = self[index - 1]
            let constraint = view.layout(attributes.first, to: attributes.second, of: previousView, offset: offset, priority: priority)!
            constraints.append(constraint)
        }
        
        if stretchEdgesToSuperview {
            let constraint = last!.layoutToSuperview(attributes.second, offset: -offset)!
            constraints.append(constraint)
        }
        
        return constraints
    }
    
    /**
     Layout elements to superview's axis
     - parameter axis: The axis: *.vertically*, *horizontally*
     - parameter offset: Additional side offset that must be applied (identical spacing from each side)
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: Array of QLAxisConstraints - see definition (discardable)
     */
    @discardableResult
    func layoutToSuperview(axis: QLAxis, offset: CGFloat = 0,
                           priority: QLPriority = .required) -> [QLAxisConstraints] {
        
        let attributes = axis.attributes
        
        let firstConstraints = layoutToSuperview(attributes.first, offset: offset, priority: priority)
        guard !firstConstraints.isEmpty else {
            return []
        }
        
        let secondConstraints = layoutToSuperview(attributes.second, offset: -offset, priority: priority)
        guard !secondConstraints.isEmpty else {
            return []
        }
        
        var constraints: [QLAxisConstraints] = []
        for (first, second) in zip(firstConstraints, secondConstraints) {
            constraints.append(QLAxisConstraints(first: first, second: second))
        }
        
        return constraints
    }
    
    /**
     Layout elements' edges to superview's edge (The same edge - top to top, bottom to bottom, etc...)
     - parameter edge: The edge of the view / superview
     - parameter ratio: The ratio of the edge in relation to the superview's (default is 1).
     - parameter offset: Additional offset from that must be applied to the constraint (default is 0).
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: Array of applied constraints - see definition (discardable)
     */
    @discardableResult
    func layoutToSuperview(_ edge: QLAttribute, ratio: CGFloat = 1, offset: CGFloat = 0,
                           priority: QLPriority = .required) -> [NSLayoutConstraint] {
        guard isValidForQuickLayout else {
            return []
        }
        return layout(to: edge, of: first!.superview!, ratio: ratio, offset: offset, priority: priority)
    }
    
    /**
     Layout elements' edges to to anchorView edge
     - parameter firstEdge: The edge of the elements in the array
     - parameter anchorEdge: The edge of the anchor view
     - parameter anchorView: The anchor view
     - parameter ratio: The ratio of the edge in relative to the superview edge (default is 1).
     - parameter offset: Additional offset from that can be applied to the constraints (default is 0).
     - parameter priority: Constraints' priority (default is *.required*).
     - returns: Array of applied constraints - see definition (discardable)
     */
    @discardableResult
    func layout(_ firstEdge: QLAttribute? = nil, to anchorEdge: QLAttribute,
                of anchorView: QLView, ratio: CGFloat = 1, offset: CGFloat = 0,
                priority: QLPriority = .required) -> [NSLayoutConstraint] {
        guard isValidForQuickLayout else {
            return []
        }
        
        let edge: QLAttribute
        if let firstEdge = firstEdge {
            edge = firstEdge
        } else {
            edge = anchorEdge
        }
        
        var result: [NSLayoutConstraint] = []
        for view in self {
            let constraint = view.layout(edge, to: anchorEdge, of: anchorView, ratio: ratio, offset: offset, priority: priority)!
            result.append(constraint)
        }
        return result
    }
    
    /**
     Layout elements' multiple edges to to anchorView's same edges (top to top, bottom to bottom, etc...)
     - parameter edges: The edges of the view - variadic parameter
     - parameter anchorView: The anchor view
     - parameter ratio: The ratio of the edge in relative to the superview edge (default is 1).
     - parameter offset: Additional offset from that can be applied to the constraints (default is 0).
     - parameter priority: Constraints' priority (default is *.required*).
     - returns: Array of applied constraints, each element is of type QLMultipleConstraints - see definition (discardable)
     */
    @discardableResult
    func layout(_ edges: QLAttribute..., to anchorView: QLView,
                ratio: CGFloat = 1, offset: CGFloat = 0,
                priority: QLPriority = .required) -> [QLMultipleConstraints] {
        guard !edges.isEmpty && isValidForQuickLayout else {
            return []
        }
        // Avoid duplicities
        let uniqueEdges = Set(edges)
        var result: [QLMultipleConstraints] = []
        for view in self {
            var multipleConstraints: QLMultipleConstraints = [:]
            for edge in uniqueEdges {
                let constraint = view.layout(to: edge, of: anchorView, ratio: ratio, offset: offset, priority: priority)!
                multipleConstraints[edge] = constraint
            }
            result.append(multipleConstraints)
        }
        return result
    }
    
    /** **PRIVATELY USED** to test for validation*/
    var isValidForQuickLayout: Bool {
        guard !isEmpty else {
            print("\(String(describing: self)) Error in func: \(#function), Views collection is empty!")
            return false
        }
        
        for view in self {
            guard view.isValidForQuickLayout else {
                print("\(String(describing: self)) Error in func: \(#function)")
                return false
            }
        }
        return true
    }
}
