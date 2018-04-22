//
//  EntryViewController.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class EKRootViewController: UIViewController {
    
    private var lastAttributes: EKAttributes!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private let backgroundView = EKBackgroundView()

    private lazy var wrapperView: EKWrapperView = {
        return EKWrapperView()
    }()
    
    private var lastEntry: EKScrollView? {
        return view.subviews.last as? EKScrollView
    }
    
    private var isResponsive: Bool = false {
        didSet {
            wrapperView.isAbleToReceiveTouches = isResponsive
            EKWindowProvider.shared.entryWindow.isAbleToReceiveTouches = isResponsive
        }
    }
    
    // MARK: Lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = wrapperView
        view.insertSubview(backgroundView, at: 0)
        backgroundView.isUserInteractionEnabled = false
        backgroundView.fillSuperview()
    }
    
    // MARK: Setup
    func configure(entryView: UIView, attributes: EKAttributes) {
        
        lastAttributes = attributes
        
        removeLastEntry(keepWindow: true)
        
        let entryScrollView = EKScrollView(withEntryDelegate: self)
        view.addSubview(entryScrollView)
        entryScrollView.setup(with: entryView, attributes: attributes)
        
        isResponsive = attributes.backgroundInteraction.isResponsive
    }

    // Removes last entry - can keep the window 'ON' if necessary
    func removeLastEntry(keepWindow: Bool) {
        if lastAttributes.options.overridesPreviousEntry {
            lastEntry?.removePromptly()
        } else {
            rollOutLastEntry()
        }
    }
    
    // Rolls out last entry - animatedly
    func rollOutLastEntry() {
        lastEntry?.animateOut(rollOut: true)
    }
}

// MARK: UIResponder
extension EKRootViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch lastAttributes.backgroundInteraction.defaultAction {
        case .dismissEntry:
            rollOutLastEntry()
            fallthrough
        default:
            lastAttributes.backgroundInteraction.customActions.forEach { $0() }
        }
    }
}

// MARK: EntryScrollViewDelegate
extension EKRootViewController: EntryScrollViewDelegate {
    
    func changeToActive(withAttributes attributes: EKAttributes) {
        changeBackground(to: attributes.background, duration: attributes.entranceAnimation.duration)
    }
    
    func changeToInactive(withAttributes attributes: EKAttributes) {
        guard EKAttributes.count <= 1 else {
            return
        }
        changeBackground(to: .none, duration: attributes.exitAnimation.duration)
    }
    
    private func changeBackground(to style: EKAttributes.BackgroundStyle, duration: TimeInterval) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
                self.backgroundView.background = style
            }, completion: nil)
        }
    }
}

