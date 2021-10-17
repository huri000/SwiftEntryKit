//
//  QLView+QuickLayout.swift
//  QuickLayout
//
//  Created by Daniel Huri on 11/19/17.
//

import Foundation
import UIKit

public extension QLView {
    
    /**
     Set constant value of an edge.
     Should be used with *width* or *height*
     - parameter edge: Edge type.
     - parameter value: Edge size.
     - parameter relation: Relation to the given constant value (default is *.equal*).
     - parameter ratio: Ratio of the cconstant constraint to actual given value (default is *1*)
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: The applied constraint (discardable).
     */
    @discardableResult
    func set(_ edge: QLAttribute, of value: CGFloat, relation: QLRelation = .equal,
             ratio: CGFloat = 1.0, priority: QLPriority = .required) -> NSLayoutConstraint {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: ratio, constant: value)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    /**
     Set constant value for multiple edges simultaniously, using variadic parameter.
     Should be used with *width* or *height*
     - parameter edges: Edge types.
     - parameter value: Edges size.
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: The applied constraints in QLMultipleConstraints - see definition (discardable).
     */
    @discardableResult
    func set(_ edges: QLAttribute..., of value: CGFloat, relation: QLRelation = .equal,
             ratio: CGFloat = 1.0, priority: QLPriority = .required) -> QLMultipleConstraints {
        return set(edges, to: value, relation: relation, ratio: ratio, priority: priority)
    }
    
    /** **PRIVATELY USED** AS A REPLACEMENT for the variadic version for the method*/
    @discardableResult
    func set(_ edges: [QLAttribute], to value: CGFloat, relation: QLRelation = .equal,
             ratio: CGFloat = 1.0, priority: QLPriority = .required) -> QLMultipleConstraints {
        var constraints: QLMultipleConstraints = [:]
        let uniqueEdges = Set(edges)
        for edge in uniqueEdges {
            let constraint = set(edge, of: value, priority: priority)
            constraints[edge] = constraint
        }
        return constraints
    }
    
    /**
     Layout edge to another view's edge.
     - You can optionally define relation, ratio, constant and priority (each gets a default value)
     - For example - Can be used to align self *left* edge to the *right* of another view.
     - *self* and *view* must be directly connected (siblings / child-parent) in the view hierarchy.
     - *superview* must not be *nil*.
     - parameter edge: The edge of the first view. If not sent or *nil* - The function automatically assumes *edge* to be *otherEdge*
     - parameter otherEdge: The edge of the second view.
     - parameter view: The second view that self must be aligned with.
     - parameter relation: The relation of the first edge to the second edge (default is .equal)
     - parameter ratio: The ratio of the edge in relative to the superview edge (default is 1).
     - parameter offset: Additional offset which is applied to the constraint (default is 0).
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: The instance of the constraint that was applied (discardable). nil if method failed to apply the constraint.
     */
    @discardableResult
    func layout(_ edge: QLAttribute? = nil, to otherEdge: QLAttribute, of view: QLView,
                relation: QLRelation = .equal, ratio: CGFloat = 1.0, offset: CGFloat = 0,
                priority: QLPriority = .required) -> NSLayoutConstraint? {
        guard isValidForQuickLayout else {
            print("\(String(describing: self)) Error in func: \(#function)")
            return nil
        }
        let constraint = NSLayoutConstraint(item: self, attribute: edge ?? otherEdge, relatedBy: relation, toItem: view, attribute: otherEdge, multiplier: ratio, constant: offset)
        constraint.priority = priority
        superview!.addConstraint(constraint)
        return constraint
    }
    
    /**
     Layout multiple edges of the view to the corresonding edges of another given view.
     - You can optionally define relation, ratio, constant and priority (each gets a default value)
     - For example - Can be used to align self *left* and *right* edges the same edge of another given view.
     - *self* and *view* must be directly connected (siblings / child-parent) in the view hierarchy.
     - *superview* must not be *nil*.
     - parameter edges: The view edges
     - parameter view: Another view that self must be aligned with.
     - parameter relation: The relation of the edges. Can be applied to *.width* or *height* for example. (default is *.equal*).
     - parameter ratio: The ratio of the edges to the other view edges (default is 1).
     - parameter offset: Additional offset which is applied to each of the constraints (default is 0).
     - parameter priority: Constraints' priority (default is *.required*).
     - returns: The instance of the constraint that was applied (discardable). *nil* if the method failed to apply the constraint.
     */
    @discardableResult
    func layout(_ edges: QLAttribute..., to view: QLView, relation: QLRelation = .equal,
                ratio: CGFloat = 1.0, offset: CGFloat = 0,
                priority: QLPriority = .required) -> QLMultipleConstraints {
        var constraints: QLMultipleConstraints = [:]
        guard isValidForQuickLayout else {
            print("\(String(describing: self)) Error in func: \(#function)")
            return constraints
        }
        let uniqueEdges = Set(edges)
        for edge in uniqueEdges {
            let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: relation, toItem: view, attribute: edge, multiplier: ratio, constant: offset)
            constraint.priority = priority
            superview!.addConstraint(constraint)
            constraints[edge] = constraint
        }
        return constraints
    }
    
    /**
     Layout edge to the same edge of superview.
     - Example of usage: *view.layoutToSuperview(.top)* makes *view* cling to the *top* of it's *superview*.
     - You can optionally define ratio, constant and priority (each gets a default value)
     - *superview* must not be *nil*.
     - parameter edge: The edge (.width, .height, .left, .right, .leading, .trailing, etc...)
     - parameter relation: The relation of the edge to the superview's corresponding edge (default is *.equal*)
     - parameter ratio: The ratio of the edge in relative to the superview edge (default is 1).
     - parameter offset: Additional offset from that can be applied to the constraint (default is 0).
     - parameter priority: Constraint's priority (default is *.required*).
     - returns: The instance of the constraint that was applied (discardable). Nil if method failed to apply constraint.
     */
    @discardableResult
    func layoutToSuperview(_ edge: QLAttribute, relation: QLRelation = .equal,
                           ratio: CGFloat = 1, offset: CGFloat = 0,
                           priority: QLPriority = .required) -> NSLayoutConstraint? {
        guard isValidForQuickLayout else {
            print("\(String(describing: self)) Error in func: \(#function)")
            return nil
        }
        let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: relation, toItem: superview, attribute: edge, multiplier: ratio, constant: offset)
        constraint.priority = priority
        superview!.addConstraint(constraint)
        return constraint
    }
    
    /**
     Layout multiple edges to the same edges as superview, using variadic parameter.
     Example for edges value:
     - You can optionally define ratio, constant and priority (each gets a default value)
     - *superview* must not be *nil*.
     - parameter edges: The edges (.width, .height, .left, .right, .leading, .trailing, etc...)
     - parameter relation: The relation of the edges to the superview's corresponding edges (default is *.equal*)
     - parameter ratio: The ratio of the edges in relative to the superview edge (default is 1).
     - parameter offset: Additional offset from that can be applied to the constraints (default is 0).
     - parameter priority: Constraints' priority (default is *.required*).
     - returns: The instance of QLMultipleConstraints - see type definition (discardable).
     */
    @discardableResult
    func layoutToSuperview(_ edges: QLAttribute..., relation: QLRelation = .equal,
                           ratio: CGFloat = 1, offset: CGFloat = 0,
                           priority: QLPriority = .required) -> QLMultipleConstraints {
        var constraints: QLMultipleConstraints = [:]
        guard !edges.isEmpty && isValidForQuickLayout else {
            return constraints
        }
        let uniqueEdges = Set(edges)
        for edge in uniqueEdges {
            let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: relation, toItem: superview, attribute: edge, multiplier: ratio, constant: offset)
            constraint.priority = priority
            superview!.addConstraint(constraint)
            constraints[edge] = constraint
        }
        return constraints
    }
    
    /**
     Layout to one of the superview's axes.
     - You can optionally define ratio, constant and priority (each gets a default value)
     - *superview* must not be *nil*.
     - parameter axis: The axis to which the view must be stretched (horizontally or vertically)
     - parameter offset: Represents an additional edge offset from that can be applied to the constraints (default is 0)
     - parameter priority: Represents constraint's priority (default is *.required*)
     - returns: The instance of the constraint that was applied (discardable).
     */
    @discardableResult
    func layoutToSuperview(axis: QLAxis, offset: CGFloat = 0,
                           priority: QLPriority = .required) -> QLAxisConstraints? {
        let attributes = axis.attributes
        guard let first = layoutToSuperview(attributes.first, offset: offset, priority: priority) else {
            return nil
        }
        guard let second = layoutToSuperview(attributes.second, offset: -offset, priority: priority) else {
            return nil
        }
        return QLAxisConstraints(first: first, second: second)
    }
    
    /**
     Size to superview with a given ratio and constant
     - *superview* must not be *nil*.
     - parameter ratio: The ratio of view to the size of superview.
     - parameter offset: Represents an additional edge offset from that can be applied to the size (default is 0)
     - parameter priority: Represents constraint's priority (default is *.required*)
     - returns: The instance of QLSizeConstraints - see definition (discardable).
     */
    @discardableResult
    func sizeToSuperview(withRatio ratio: CGFloat = 1, offset: CGFloat = 0,
                         priority: QLPriority = .required) -> QLSizeConstraints? {
        let size = layoutToSuperview(.width, .height, ratio: ratio, offset: offset, priority: priority)
        guard !size.isEmpty else {
            return nil
        }
        return QLSizeConstraints(width: size[.width]!, height: size[.height]!)
    }
    
    /**
     Center in superview with an optional offset
     - *superview* must not be *nil*.
     - parameter offset: Represents an additional offset from the center (default is 0)
     - parameter priority: Represents constraint's priority (default is *.required*)
     - returns: The instance of QLCenterConstraints - see definition (discardable).
     */
    @discardableResult
    func centerInSuperview(offset: CGFloat = 0, priority: QLPriority = .required) -> QLCenterConstraints? {
        let center = layoutToSuperview(.centerX, .centerY, offset: offset)
        guard !center.isEmpty else {
            return nil
        }
        return QLCenterConstraints(x: center[.centerX]!, y: center[.centerY]!)
    }
    
    /**
     Fill superview totally (center and size to superview)
     - *superview* must not be *nil*.
     - parameter ratio: Ratio to the superview's size (default is 1)
     - parameter offset: Offset from center (default is 0)
     - parameter priority: Represents constraint's priority (default is *.required*)
     - returns: The instance of QLFillConstraints - see definition (discardable).
     */
    @discardableResult
    func fillSuperview(withSizeRatio ratio: CGFloat = 1, offset: CGFloat = 0,
                       priority: QLPriority = .required) -> QLFillConstraints? {
        guard let center = centerInSuperview(priority: priority) else {
            return nil
        }
        guard let size = sizeToSuperview(withRatio: ratio, offset: offset, priority: priority) else {
            return nil
        }
        return QLFillConstraints(center: center, size: size)
    }
    
    /** **PRIVATELY USED** to test for validation*/
    var isValidForQuickLayout: Bool {
        guard superview != nil else {
            print("\(String(describing: self)):\(#function) - superview is unexpectedly nullified")
            return false
        }
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
        return true
    }
}
