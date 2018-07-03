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
    
    /** The window to rollback to after dismissal */
    public enum RollbackWindow {
        case main
        case custom(window: UIWindow)
    }
    
    /** Completion handler for the dismissal method */
    public typealias DismissCompletionHandler = () -> Void
    
    /** Cannot be instantiated, customized, inherited. */
    private init() {}
    
    /**
     Returns true if an entry is currently displayed.
     Not thread safe - should be called from the main queue only in order to receive a reliable result.
     */
    public class var isCurrentlyDisplaying: Bool {
        return EKAttributes.isDisplaying
    }
    
    /**
     Displays a given entry view using an attributes struct.
     - A thread-safe method - Can be invokes from any thread
     - A class method - Should be called on the class
     - parameter view: Custom view that is to be displayed
     - parameter attributes: Display properties
     - parameter presentInsideKeyWindow: Indicates whether the entry window should become the key window.
     - parameter rollbackWindow: After the entry has been dismissed, SwiftEntryKit rolls back to the given window. By default it is *.main* which is the app main window
     */
    public class func display(entry view: UIView, using attributes: EKAttributes, presentInsideKeyWindow: Bool = false, rollbackWindow: RollbackWindow = .main) {
        DispatchQueue.main.async {
            EKWindowProvider.shared.display(view: view, using: attributes, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
        }
    }
    
    /**
     Displays a given entry view controller using an attributes struct.
     - A thread-safe method - Can be invokes from any thread
     - A class method - Should be called on the class
     - parameter view: Custom view that is to be displayed
     - parameter attributes: Display properties
     - parameter presentInsideKeyWindow: Indicates whether the entry window should become the key window.
     - parameter rollbackWindow: After the entry has been dismissed, SwiftEntryKit rolls back to the given window. By default it is *.main* - which is the app main window
     */
    public class func display(entry viewController: UIViewController, using attributes: EKAttributes, presentInsideKeyWindow: Bool = false, rollbackWindow: RollbackWindow = .main) {
        DispatchQueue.main.async {
            EKWindowProvider.shared.display(viewController: viewController, using: attributes, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
        }
    }
    
    /**
     ALPHA FEATURE: Transform the previous entry to the current one using the previous attributes struct.
     - A thread-safe method - Can be invokes from any thread.
     - A class method - Should be called on the class.
     - This feature hasn't been fully tested. Use with caution.
     - parameter view: Custom view that is to be displayed instead of the currently displayed entry
     */
    public class func transform(to view: UIView) {
        DispatchQueue.main.async {
            EKWindowProvider.shared.transform(to: view)
        }
    }
    
    /**
     Dismisses the currently presented entry and removes the presented window instance after the exit animation is concluded.
     - A thread-safe method - Can be invokes from any thread.
     - A class method - Should be called on the class.
     - parameter completion: A completion handler that is to be called right after the entry is dismissed (After the animation is concluded).
     */
    public class func dismiss(with completion: DismissCompletionHandler? = nil) {
        DispatchQueue.main.async {
            EKWindowProvider.shared.dismiss(with: completion)
        }
    }
    
    /**
     Layout the view hierarchy that is rooted in the window.
     - In case you use complex animations, you can call it to refresh the AutoLayout mechanism on the entire view hierarchy.
     - A thread-safe method - Can be invokes from any thread.
     - A class method - Should be called on the class.
     */
    public class func layoutIfNeeded() {
        if Thread.isMainThread {
            EKWindowProvider.shared.layoutIfNeeded()
        } else {
            DispatchQueue.main.async {
                EKWindowProvider.shared.layoutIfNeeded()
            }
        }
    }
}
