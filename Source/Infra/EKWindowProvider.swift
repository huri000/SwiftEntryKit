//
//  EKWindowProvider.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

final class EKWindowProvider {
    
    /** The artificial safe area insets */
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return EKWindowProvider.shared.entryWindow?.rootViewController?.view?.safeAreaInsets ?? UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets ?? .zero
        } else {
            let statusBarMaxY = UIApplication.shared.statusBarFrame.maxY
            return UIEdgeInsets(top: statusBarMaxY, left: 0, bottom: 10, right: 0)
        }
    }
    
    /** Single access point */
    static let shared = EKWindowProvider()
    
    /** Current entry window */
    var entryWindow: EKWindow!
    
    /** Returns the root view controller if it is instantiated */
    var rootVC: EKRootViewController? {
        return entryWindow?.rootViewController as? EKRootViewController
    }
    
    /** A window to go back to when the last entry has been dismissed */
    private var rollbackWindow: SwiftEntryKit.RollbackWindow!
    
    private weak var entryView: EKEntryView!

    /** Cannot be instantiated, customized, inherited */
    private init() {}
    
    // MARK: - Setup and Teardown methods
    
    // Prepare the window and the host view controller
    private func prepare(for attributes: EKAttributes, presentInsideKeyWindow: Bool) -> EKRootViewController? {
        let entryVC = setupWindowAndRootVC()
        guard entryVC.canDisplay(attributes: attributes) else {
            return nil
        }
        entryVC.setStatusBarStyle(for: attributes)

        entryWindow.windowLevel = attributes.windowLevel.value
        if presentInsideKeyWindow {
            entryWindow.makeKeyAndVisible()
        } else {
            entryWindow.isHidden = false
        }

        return entryVC
    }
    
    /** Boilerplate generic setup for entry-window and root-view-controller  */
    private func setupWindowAndRootVC() -> EKRootViewController {
        let entryVC: EKRootViewController
        if entryWindow == nil {
            entryVC = EKRootViewController()
            entryWindow = EKWindow(with: entryVC)
        } else {
            entryVC = rootVC!
        }
        return entryVC
    }
    
    // MARK: - Exposed Actions
    
    /**
     Returns *true* if the currently displayed entry has the given name.
     In case *name* has the value of *nil*, the result is *true* if any entry is currently displayed.
     */
    func isCurrentlyDisplaying(entryNamed name: String?) -> Bool {
        guard let entryView = entryView else {
            return false
        }
        if let name = name { // Test for names equality
            return entryView.content.attributes.name == name
        } else { // Return true by default if the name is *nil*
            return true
        }
    }
    
    /** Transform current entry to view */
    func transform(to view: UIView) {
        entryView?.transform(to: view)
    }
    
    /** Display a view using attributes */
    func display(view: UIView, using attributes: EKAttributes, presentInsideKeyWindow: Bool, rollbackWindow: SwiftEntryKit.RollbackWindow) {
        guard let entryVC = prepare(for: attributes, presentInsideKeyWindow: presentInsideKeyWindow) else {
            return
        }
        let entryView = EKEntryView(newEntry: .init(view: view, attributes: attributes))
        entryVC.configure(entryView: entryView)
        self.entryView = entryView
        self.rollbackWindow = rollbackWindow
    }
    
    /** Display a view controller using attributes */
    func display(viewController: UIViewController, using attributes: EKAttributes, presentInsideKeyWindow: Bool, rollbackWindow: SwiftEntryKit.RollbackWindow) {
        guard let entryVC = prepare(for: attributes, presentInsideKeyWindow: presentInsideKeyWindow) else {
            return
        }
        let entryView = EKEntryView(newEntry: .init(viewController: viewController, attributes: attributes))
        entryVC.configure(entryView: entryView)
        self.entryView = entryView
        self.rollbackWindow = rollbackWindow
    }
    
    /** Clear all entries immediately and display to the rollback window */
    func displayRollbackWindow() {
        entryWindow = nil
        entryView = nil
        switch rollbackWindow! {
        case .main:
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        case .custom(window: let window):
            window.makeKeyAndVisible()
        }
    }
    
    /** Dismiss the current entry */
    func dismiss(with completion: SwiftEntryKit.DismissCompletionHandler? = nil) {
        guard let rootVC = rootVC else {
            return
        }
        rootVC.animateOutLastEntry(completionHandler: completion)
    }
    
    /** Layout the view-hierarchy rooted in the window */
    func layoutIfNeeded() {
        entryWindow?.layoutIfNeeded()
    }
}
