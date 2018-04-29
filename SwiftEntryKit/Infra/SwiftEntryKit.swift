//
//  SwiftEntryKit.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/29/18.
//

import Foundation

public final class SwiftEntryKit {
    
    // Cannot be instantiated / Inherited
    private init() {}
    
    /** Call display to present an entry with a UIView and EKAttributes */
    public class func display(entry view: UIView, using attributes: EKAttributes) {
        EKWindowProvider.shared.state = .entry(view: view, attributes: attributes)
    }
    
    /** Call dismiss to dismiss the currently presented entry */
    public class func dismiss() {
        EKWindowProvider.shared.dismiss()
    }
    
    /** In case you use complex animations, you can call it to refresh the AutoLayout on the whole view hierarchy */
    public class func layoutIfNeeded() {
        EKWindowProvider.shared.layoutIfNeeded()
    }
}
