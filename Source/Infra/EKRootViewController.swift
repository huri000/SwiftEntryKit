//
//  EntryViewController.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

protocol EntryPresenterDelegate: class {
    var isResponsiveToTouches: Bool { set get }
    func displayPendingEntryIfNeeded()
}

class EKRootViewController: UIViewController {
    
    // MARK: - Props
    
    private unowned let delegate: EntryPresenterDelegate
    
    private var lastAttributes: EKAttributes!
    
    private let backgroundView = EKBackgroundView()

    // Previous status bar style
    private let previousStatusBar: EKAttributes.StatusBar
    
    private lazy var wrapperView: EKWrapperView = {
        return EKWrapperView()
    }()
    
    private var statusBar: EKAttributes.StatusBar? = nil {
        didSet {
            if let statusBar = statusBar {
                UIApplication.shared.set(statusBarStyle: statusBar)
            }
        }
    }
    
    fileprivate var displayingEntryCount: Int {
        return view.subviews.count
    }
    
    fileprivate var isDisplaying: Bool {
        return lastEntry != nil
    }
    
    private var lastEntry: EKContentView? {
        return view.subviews.last as? EKContentView
    }
        
    private var isResponsive = false {
        didSet {
            wrapperView.isAbleToReceiveTouches = isResponsive
            delegate.isResponsiveToTouches = isResponsive
        }
    }

    override var shouldAutorotate: Bool {
        if lastAttributes == nil {
            return true
        }
        return lastAttributes.positionConstraints.isRotationEnabled
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBar?.appearance.style ?? previousStatusBar.appearance.style
    }

    override var prefersStatusBarHidden: Bool {
        return !(statusBar?.appearance.visible ?? previousStatusBar.appearance.visible)
    }
    
    // MARK: - Lifecycle
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(with delegate: EntryPresenterDelegate) {
        self.delegate = delegate
        previousStatusBar = .currentStatusBar
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func loadView() {
        view = wrapperView
        view.insertSubview(backgroundView, at: 0)
        backgroundView.isUserInteractionEnabled = false
        backgroundView.fillSuperview()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBar = previousStatusBar
    }
    
    // Set status bar
    func setStatusBarStyle(for attributes: EKAttributes) {
        statusBar = attributes.statusBar
    }
    
    // MARK: - Setup
    
    func configure(entryView: EKEntryView) {

        // In case the entry is a view controller, add the entry as child of root
        if let viewController = entryView.content.viewController {
            addChildViewController(viewController)
        }
        
        // Extract the attributes struct
        let attributes = entryView.attributes
        
        // Assign attributes
        let previousAttributes = lastAttributes
        
        // Remove the last entry
        removeLastEntry(lastAttributes: previousAttributes, keepWindow: true)
        
        lastAttributes = attributes
        
        let entryContentView = EKContentView(withEntryDelegate: self)
        view.addSubview(entryContentView)
        entryContentView.setup(with: entryView)
        
        isResponsive = attributes.screenInteraction.isResponsive
        if previousAttributes?.statusBar != attributes.statusBar {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
        
    // Check priority precedence for a given entry
    func canDisplay(attributes: EKAttributes) -> Bool {
        guard let lastAttributes = lastAttributes else {
            return true
        }
        return attributes.precedence.priority >= lastAttributes.precedence.priority
    }

    // Removes last entry - can keep the window 'ON' if necessary
    private func removeLastEntry(lastAttributes: EKAttributes?, keepWindow: Bool) {
        guard let attributes = lastAttributes else {
            return
        }
        if attributes.popBehavior.isOverriden {
            lastEntry?.removePromptly()
        } else {
            popLastEntry()
        }
    }
    
    // Make last entry exit using exitAnimation - animatedly
    func animateOutLastEntry(completionHandler: SwiftEntryKit.DismissCompletionHandler? = nil) {
        lastEntry?.dismissHandler = completionHandler
        lastEntry?.animateOut(pushOut: false)
    }
    
    // Pops last entry (using pop animation) - animatedly
    func popLastEntry() {
        lastEntry?.animateOut(pushOut: true)
    }
}

// MARK: - UIResponder

extension EKRootViewController {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch lastAttributes.screenInteraction.defaultAction {
        case .dismissEntry:
            lastEntry?.animateOut(pushOut: false)
            fallthrough
        default:
            lastAttributes.screenInteraction.customTapActions.forEach { $0() }
        }
    }
}

// MARK: - EntryScrollViewDelegate

extension EKRootViewController: EntryContentViewDelegate {
    
    func didFinishDisplaying(entry: EKEntryView, keepWindowActive: Bool) {
        guard !isDisplaying else {
            return
        }
        
        guard !keepWindowActive else {
            return
        }
        
        delegate.displayPendingEntryIfNeeded()
    }
    
    func changeToActive(withAttributes attributes: EKAttributes) {
        changeBackground(to: attributes.screenBackground, duration: attributes.entranceAnimation.totalDuration)
    }
    
    func changeToInactive(withAttributes attributes: EKAttributes, pushOut: Bool) {
        guard displayingEntryCount <= 1 else {
            return
        }
        
        let clear = {
            self.changeBackground(to: .clear, duration: attributes.exitAnimation.totalDuration)
        }
        
        guard pushOut else {
            clear()
            return
        }
        
        guard let lastBackroundStyle = lastAttributes?.screenBackground else {
            clear()
            return
        }
        
        if lastBackroundStyle != attributes.screenBackground {
            clear()
        }
    }
    
    private func changeBackground(to style: EKAttributes.BackgroundStyle, duration: TimeInterval) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
                self.backgroundView.background = style
            }, completion: nil)
        }
    }
}

