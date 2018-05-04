//
//  EntryViewController.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class EKRootViewController: UIViewController {
    
    // MARK: Props
    private var lastAttributes: EKAttributes!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private let backgroundView = EKBackgroundView()

    // Previous status bar style
    private var previousStatusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle
    
    private lazy var wrapperView: EKWrapperView = {
        return EKWrapperView()
    }()
    
    private var lastEntry: EKContentView? {
        return view.subviews.last as? EKContentView
    }
    
    private var isResponsive: Bool = false {
        didSet {
            wrapperView.isAbleToReceiveTouches = isResponsive
            EKWindowProvider.shared.entryWindow.isAbleToReceiveTouches = isResponsive
        }
    }
    
    // MARK: Lifecycle
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
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
        UIApplication.shared.statusBarStyle = previousStatusBarStyle
    }
    
    // MARK: Setup
    func configure(newEntryView: UIView, attributes: EKAttributes) {
        guard checkPriorityPrecedence(for: attributes) else {
            return
        }
        
        removeLastEntry(keepWindow: true)

        lastAttributes = attributes
        
        setStatusBarStyle(by: attributes)
                
        let entryContentView = EKContentView(withEntryDelegate: self)
        view.addSubview(entryContentView)
        entryContentView.setup(with: newEntryView, attributes: attributes)
        
        isResponsive = attributes.screenInteraction.isResponsive
    }
    
    private func setStatusBarStyle(by attributes: EKAttributes) {
        guard let style = attributes.statusBarStyle, style != UIApplication.shared.statusBarStyle else {
            return
        }
        UIApplication.shared.statusBarStyle = style
    }
    
    // Check priority precedence for a given entry
    private func checkPriorityPrecedence(for attributes: EKAttributes) -> Bool {
        guard let lastAttributes = lastAttributes else {
            return true
        }
        return attributes.displayPriority >= lastAttributes.displayPriority
    }

    // Removes last entry - can keep the window 'ON' if necessary
    private func removeLastEntry(keepWindow: Bool) {
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
    func animateOutLastEntry() {
        lastEntry?.animateOut(pushOut: false)
    }
    
    // Pops last entry (using pop animation) - animatedly
    func popLastEntry() {
        lastEntry?.animateOut(pushOut: true)
    }
}

// MARK: UIResponder
extension EKRootViewController {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch lastAttributes.screenInteraction.defaultAction {
        case .dismissEntry:
            lastEntry?.animateOut(pushOut: false)
            fallthrough
        default:
            lastAttributes.screenInteraction.customTapActions.forEach { $0() }
        }
    }
}

// MARK: EntryScrollViewDelegate
extension EKRootViewController: EntryContentViewDelegate {
    
    func changeToActive(withAttributes attributes: EKAttributes) {
        changeBackground(to: attributes.screenBackground, duration: attributes.entranceAnimation.totalDuration)
    }
    
    func changeToInactive(withAttributes attributes: EKAttributes) {
        guard EKAttributes.count <= 1 else {
            return
        }
        changeBackground(to: .clear, duration: attributes.exitAnimation.totalDuration)
    }
    
    private func changeBackground(to style: EKAttributes.BackgroundStyle, duration: TimeInterval) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
                self.backgroundView.background = style
            }, completion: nil)
        }
    }
}

