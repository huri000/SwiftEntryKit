//
//  EKWindowProvider.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

final class EKWindowProvider: EntryPresenterDelegate {
    
    static func safeAreaInsets(_ windows: UIWindow?) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return windows?.rootViewController?.view?.safeAreaInsets ?? UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets ?? .zero
        } else {
            let statusBarMaxY = UIApplication.shared.statusBarFrame.maxY
            return UIEdgeInsets(top: statusBarMaxY, left: 0, bottom: 10, right: 0)
        }
    }
    
    /** Current entry window */
    var entryWindow: EKWindow!
    
    /** Returns the root view controller if it is instantiated */
    var rootVC: EKRootViewController? {
        return entryWindow?.rootViewController as? EKRootViewController
    }
    
    /** A window to go back to when the last entry has been dismissed */
    private var rollbackWindow: SwiftEntryKit.RollbackWindow!

    /** Entry queueing heuristic  */
    private let entryQueue = EKAttributes.Precedence.QueueingHeuristic.value.heuristic
    
    private weak var entryView: EKEntryView!

    /** Cannot be instantiated, customized, inherited */
    init() {}
    
    var isResponsiveToTouches: Bool {
        set {
            entryWindow.isAbleToReceiveTouches = newValue
        }
        get {
            return entryWindow.isAbleToReceiveTouches
        }
    }
    
    // MARK: - Setup and Teardown methods
    
    // Prepare the window and the host view controller
    private func prepare(for attributes: EKAttributes, presentInsideKeyWindow: Bool) -> EKRootViewController? {
        let entryVC = setupWindowAndRootVC()
        guard entryVC.canDisplay(attributes: attributes) || attributes.precedence.isEnqueue else {
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
            entryVC = EKRootViewController(with: self)
            entryWindow = EKWindow(with: entryVC)
        } else {
            entryVC = rootVC!
        }
        return entryVC
    }
    
    /**
     Privately used to display an entry
     */
    private func display(entryView: EKEntryView, using attributes: EKAttributes, presentInsideKeyWindow: Bool, rollbackWindow: SwiftEntryKit.RollbackWindow) {
        switch entryView.attributes.precedence {
        case .override(priority: _, dropEnqueuedEntries: let dropEnqueuedEntries):
            if dropEnqueuedEntries {
                entryQueue.removeAll()
            }
            show(entryView: entryView, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
        case .enqueue where isCurrentlyDisplaying():
            entryQueue.enqueue(entry: .init(view: entryView, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow))
        case .enqueue:
            show(entryView: entryView, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
        }
    }
    
    // MARK: - Exposed Actions
    
    func queueContains(entryNamed name: String? = nil) -> Bool {
        if name == nil && !entryQueue.isEmpty {
            return true
        }
        if let name = name {
            return entryQueue.contains(entryNamed: name)
        } else {
            return false
        }
    }
    
    /**
     Returns *true* if the currently displayed entry has the given name.
     In case *name* has the value of *nil*, the result is *true* if any entry is currently displayed.
     */
    func isCurrentlyDisplaying(entryNamed name: String? = nil) -> Bool {
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
        let entryView = EKEntryView(newEntry: .init(view: view, attributes: attributes))
        display(entryView: entryView, using: attributes, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
    }

    /** Display a view controller using attributes */
    func display(viewController: UIViewController, using attributes: EKAttributes, presentInsideKeyWindow: Bool, rollbackWindow: SwiftEntryKit.RollbackWindow) {
        let entryView = EKEntryView(newEntry: .init(viewController: viewController, attributes: attributes))
        display(entryView: entryView, using: attributes, presentInsideKeyWindow: presentInsideKeyWindow, rollbackWindow: rollbackWindow)
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
    
    /** Display a pending entry if there is any inside the queue */
    func displayPendingEntryIfNeeded() {
        if let next = entryQueue.dequeue() {
            show(entryView: next.view, presentInsideKeyWindow: next.presentInsideKeyWindow, rollbackWindow: next.rollbackWindow)
        } else {
            displayRollbackWindow()
        }
    }
    
    /** Dismiss entries according to a given descriptor */
    func dismiss(_ descriptor: SwiftEntryKit.EntryDismissalDescriptor, with completion: SwiftEntryKit.DismissCompletionHandler? = nil) {
        guard let rootVC = rootVC else {
            return
        }
        
        switch descriptor {
        case .displayed:
            rootVC.animateOutLastEntry(completionHandler: completion)
        case .specific(entryName: let name):
            entryQueue.removeEntries(by: name)
            if entryView?.attributes.name == name {
                rootVC.animateOutLastEntry(completionHandler: completion)
            }
        case .prioritizedLowerOrEqualTo(priority: let priorityThreshold):
            entryQueue.removeEntries(withPriorityLowerOrEqualTo: priorityThreshold)
            if let currentPriority = entryView?.attributes.precedence.priority, currentPriority <= priorityThreshold {
                rootVC.animateOutLastEntry(completionHandler: completion)
            }
        case .enqueued:
            entryQueue.removeAll()
        case .all:
            entryQueue.removeAll()
            rootVC.animateOutLastEntry(completionHandler: completion)
        }
    }
    
    /** Layout the view-hierarchy rooted in the window */
    func layoutIfNeeded() {
        entryWindow?.layoutIfNeeded()
    }
    
    /** Privately using to prepare the root view controller and show the entry immediately */
    private func show(entryView: EKEntryView, presentInsideKeyWindow: Bool, rollbackWindow: SwiftEntryKit.RollbackWindow) {
        guard let entryVC = prepare(for: entryView.attributes, presentInsideKeyWindow: presentInsideKeyWindow) else {
            return
        }
        entryVC.configure(entryView: entryView)
        self.entryView = entryView
        self.rollbackWindow = rollbackWindow
    }
}
