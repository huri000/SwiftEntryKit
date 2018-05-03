//
//  SwiftEntryKit.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/29/18.
//

import Foundation

/**
 A stateless, threadsafe entry point that contains the display and the dismissal logic of entries.
 */
public final class SwiftEntryKit {
    
    // Cannot be instantiated or inherited.
    private init() {}
    
    /**
     Displays a given entry view using a given attributes struct.
     - A thread-safe method - Can be invokes from anywhere.
     - A class method - Should be called on the class.
     - parameter view: Custom view that is to be displayed
     - parameter attributes: Attributes (The display properties)
     */
    public class func display(entry view: UIView, using attributes: EKAttributes) {
        executeUIAction {
            EKWindowProvider.shared.state = .entry(view: view, attributes: attributes)
        }
    }
    
    /**
     Dismisses the currently presented entry and removes the presented window instance.
     - A thread-safe method - Can be invokes from anywhere.
     - A class method - Should be called on the class.
     */
    public class func dismiss() {
        executeUIAction {
            EKWindowProvider.shared.dismiss()
        }
    }
    
    /**
     Layout the view hierarchy that is rooted in the window.
     - In case you use complex animations, you can call it to refresh the AutoLayout mechanism on the entire view hierarchy.
     - A thread-safe method - Can be invokes from anywhere.
     - A class method - Should be called on the class.
     */
    public class func layoutIfNeeded() {
        executeUIAction {
            EKWindowProvider.shared.layoutIfNeeded()
        }
    }
    
    // A Precaution: Executes a UI action on the main thread, thus letting any of the class methods of SwiftEntryKit to be invokes even from a background thread.
    private class func executeUIAction(_ action: @escaping () -> ()) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}
