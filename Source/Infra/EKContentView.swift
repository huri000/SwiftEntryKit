//
//  EKScrollView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

protocol EntryContentViewDelegate: AnyObject {
    func changeToActive(withAttributes attributes: EKAttributes)
    func changeToInactive(withAttributes attributes: EKAttributes, pushOut: Bool)
    func didFinishDisplaying(entry: EKEntryView, keepWindowActive: Bool, dismissCompletionHandler: SwiftEntryKit.DismissCompletionHandler?)
}

class EKContentView: UIView {
    
    enum OutTranslation {
        case exit
        case pop
        case swipeDown
        case swipeUp
    }
    
    struct OutTranslationAnchor {
        var messageOut: QLAttribute
        var screenOut: QLAttribute
        
        init(_ messageOut: QLAttribute, to screenOut: QLAttribute) {
            self.messageOut = messageOut
            self.screenOut = screenOut
        }
    }
    
    // MARK: Props
    
    // Entry delegate
    private weak var entryDelegate: EntryContentViewDelegate!
    
    // Constraints and Offsets
    private var entranceOutConstraint: NSLayoutConstraint!
    private var exitOutConstraint: NSLayoutConstraint!
    private var swipeDownOutConstraint: NSLayoutConstraint!
    private var swipeUpOutConstraint: NSLayoutConstraint!
    private var popOutConstraint: NSLayoutConstraint!
    private var inConstraint: NSLayoutConstraint!
    private var resistanceConstraint: NSLayoutConstraint!
    private var inKeyboardConstraint: NSLayoutConstraint!
    
    private var inOffset: CGFloat = 0
    private var totalTranslation: CGFloat = 0
    private var verticalLimit: CGFloat = 0
    private let swipeMinVelocity: CGFloat = 60
    
    private var outDispatchWorkItem: DispatchWorkItem!

    private var keyboardState = KeyboardState.hidden
    
    // Dismissal handler
    var dismissHandler: SwiftEntryKit.DismissCompletionHandler?
    
    // Data source
    private var attributes: EKAttributes {
        return contentView.attributes
    }
    
    // Content
    private var contentView: EKEntryView!
    
    // MARK: Setup
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withEntryDelegate entryDelegate: EntryContentViewDelegate) {
        self.entryDelegate = entryDelegate
        super.init(frame: .zero)
    }
    
    // Called from outer scope with a presentable view and attributes
    func setup(with contentView: EKEntryView) {
        
        self.contentView = contentView
        
        // Execute willAppear lifecycle action if needed
        contentView.attributes.lifecycleEvents.willAppear?()
        
        // Setup attributes
        setupAttributes()

        // Setup initial position
        setupInitialPosition()
        
        // Setup width, height and maximum width
        setupLayoutConstraints()
        
        // Animate in
        animateIn()
        
        // Setup tap gesture
        setupTapGestureRecognizer()
        
        // Generate haptic feedback
        generateHapticFeedback()
        
        setupKeyboardChangeIfNeeded()
    }
    
    // Setup the scrollView initial position
    private func setupInitialPosition() {
        
        // Determine the layout entrance type according to the entry type
        let messageInAnchor: NSLayoutConstraint.Attribute
        
        inOffset = 0
        
        var totalEntryHeight: CGFloat = 0
        
        // Define a spacer to catch top / bottom offsets
        var spacerView: UIView!
        let safeAreaInsets = EKWindowProvider.safeAreaInsets
        let overrideSafeArea = attributes.positionConstraints.safeArea.isOverridden
        
        if !overrideSafeArea && safeAreaInsets.hasVerticalInsets && !attributes.position.isCenter {
            spacerView = UIView()
            addSubview(spacerView)
            spacerView.set(.height, of: safeAreaInsets.top)
            spacerView.layoutToSuperview(.width, .centerX)
            
            totalEntryHeight += safeAreaInsets.top
        }
        
        switch attributes.position {
        case .top:
            messageInAnchor = .top
            inOffset = overrideSafeArea ? 0 : safeAreaInsets.top
            inOffset += attributes.positionConstraints.verticalOffset
            spacerView?.layout(.bottom, to: .top, of: self)
        case .bottom:
            messageInAnchor = .bottom
            inOffset = overrideSafeArea ? 0 : -safeAreaInsets.bottom
            inOffset -= attributes.positionConstraints.verticalOffset
            spacerView?.layout(.top, to: .bottom, of: self)
        case .center:
            messageInAnchor = .centerY
        }
        
        // Layout the content view inside the scroll view
        addSubview(contentView)
        contentView.layoutToSuperview(.left, .right, .top, .bottom)
        contentView.layoutToSuperview(.width, .height)
        
        inConstraint = layout(to: messageInAnchor, of: superview!, offset: inOffset, priority: .defaultLow)
        
        // Set position constraints
        setupOutConstraints(messageInAnchor: messageInAnchor)
        
        totalTranslation = inOffset
        switch attributes.position {
        case .top:
            verticalLimit = inOffset
        case .bottom, .center:
            verticalLimit = UIScreen.main.bounds.height + inOffset
        }
        
        // Setup keyboard constraints
        switch attributes.positionConstraints.keyboardRelation {
        case .bind(offset: let offset):
            if let screenEdgeResistance = offset.screenEdgeResistance {
                resistanceConstraint = layoutToSuperview(.top, relation: .greaterThanOrEqual, offset: screenEdgeResistance, priority: .defaultLow)
            }
            inKeyboardConstraint = layoutToSuperview(.bottom, priority: .defaultLow)
        default:
            break
        }
    }
    
    private func setupOutConstraint(animation: EKAttributes.Animation?, messageInAnchor: QLAttribute, priority: QLPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        if let translation = animation?.translate {
            var anchor: OutTranslationAnchor
            switch translation.anchorPosition {
            case .top:
                anchor = OutTranslationAnchor(.bottom, to: .top)
            case .bottom:
                anchor = OutTranslationAnchor(.top, to: .bottom)
            case .automatic where attributes.position.isTop:
                anchor = OutTranslationAnchor(.bottom, to: .top)
            case .automatic: // attributes.position.isBottom:
                anchor = OutTranslationAnchor(.top, to: .bottom)
            }
            constraint = layout(anchor.messageOut, to: anchor.screenOut, of: superview!, priority: priority)!
        } else {
            constraint = layout(to: messageInAnchor, of: superview!, offset: inOffset, priority: priority)!
        }
        return constraint
    }
    
    // Setup out constraints - taking into account the full picture and all the possible use-cases
    private func setupOutConstraints(messageInAnchor: QLAttribute) {
        
        // Setup entrance and exit out constraints
        entranceOutConstraint = setupOutConstraint(animation: attributes.entranceAnimation, messageInAnchor: messageInAnchor, priority: .must)
        exitOutConstraint = setupOutConstraint(animation: attributes.exitAnimation, messageInAnchor: messageInAnchor, priority: .defaultLow)
        swipeDownOutConstraint = layout(.top, to: .bottom, of: superview!, priority: .defaultLow)!
        swipeUpOutConstraint = layout(.bottom, to: .top, of: superview!, priority: .defaultLow)!
        
        // Setup pop out constraint
        var popAnimation: EKAttributes.Animation?
        if case .animated(animation: let animation) = attributes.popBehavior {
            popAnimation = animation
        }
        popOutConstraint = setupOutConstraint(animation: popAnimation, messageInAnchor: messageInAnchor, priority: .defaultLow)
    }
    
    
    private func setupSize() {
        
        // Layout the scroll view horizontally inside the screen
        switch attributes.positionConstraints.size.width {
        case .offset(value: let offset):
            layoutToSuperview(axis: .horizontally, offset: offset, priority: .must)
        case .ratio(value: let ratio):
            layoutToSuperview(.width, ratio: ratio, priority: .must)
        case .constant(value: let constant):
            set(.width, of: constant, priority: .must)
        case .intrinsic:
            break
        }
        
        // Layout the scroll view vertically inside the screen
        switch attributes.positionConstraints.size.height {
        case .offset(value: let offset):
            layoutToSuperview(.height, offset: -offset * 2, priority: .must)
        case .ratio(value: let ratio):
            layoutToSuperview(.height, ratio: ratio, priority: .must)
        case .constant(value: let constant):
            set(.height, of: constant, priority: .must)
        case .intrinsic:
            break
        }
    }
    
    private func setupMaxSize() {
        
        // Layout the scroll view according to the maximum width (if given any)
        switch attributes.positionConstraints.maxSize.width {
        case .offset(value: let offset):
            layout(to: .left, of: superview!, relation: .greaterThanOrEqual, offset: offset)
            layout(to: .right, of: superview!, relation: .lessThanOrEqual, offset: -offset)
        case .ratio(value: let ratio):
            layoutToSuperview(.centerX)
            layout(to: .width, of: superview!, relation: .lessThanOrEqual, ratio: ratio)
        case .constant(value: let constant):
            set(.width, of: constant, relation: .lessThanOrEqual)
            break
        case .intrinsic:
            break
        }
        
        // Layout the scroll view according to the maximum width (if given any)
        switch attributes.positionConstraints.maxSize.height {
        case .offset(value: let offset):
            layout(to: .height, of: superview!, relation: .lessThanOrEqual, offset: -offset * 2)
        case .ratio(value: let ratio):
            layout(to: .height, of: superview!, relation: .lessThanOrEqual, ratio: ratio)
        case .constant(value: let constant):
            set(.height, of: constant, relation: .lessThanOrEqual)
            break
        case .intrinsic:
            break
        }
    }
    
    // Setup layout constraints according to EKAttributes.PositionConstraints
    private func setupLayoutConstraints() {
        layoutToSuperview(.centerX)
        setupSize()
        setupMaxSize()
    }

    // Setup general attributes
    private func setupAttributes() {
        clipsToBounds = false
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(gr:)))
        panGestureRecognizer.isEnabled = attributes.scroll.isEnabled
        addGestureRecognizer(panGestureRecognizer)
    }
    
    // Setup tap gesture
    private func setupTapGestureRecognizer() {
        switch attributes.entryInteraction.defaultAction {
        case .forward:
            return
        default:
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
            tapGestureRecognizer.numberOfTapsRequired = 1
            tapGestureRecognizer.cancelsTouchesInView = false
            addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    // Generate a haptic feedback if needed
    private func generateHapticFeedback() {
        guard #available(iOS 10.0, *) else {
            return
        }
        HapticFeedbackGenerator.notification(type: attributes.hapticFeedbackType)
    }
    
    // MARK: Animations
    
    // Schedule out animation
    private func scheduleAnimateOut(withDelay delay: TimeInterval? = nil) {
        outDispatchWorkItem?.cancel()
        outDispatchWorkItem = DispatchWorkItem { [weak self] in
            self?.animateOut(pushOut: false)
        }
        let delay = attributes.entranceAnimation.totalDuration + (delay ?? attributes.displayDuration)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: outDispatchWorkItem)
    }
    
    // Animate out
    func animateOut(pushOut: Bool) {
        
        // Execute willDisappear action if needed
        contentView.attributes.lifecycleEvents.willDisappear?()
        
        if attributes.positionConstraints.keyboardRelation.isBound {
            endEditing(true)
        }
        
        outDispatchWorkItem?.cancel()
        entryDelegate?.changeToInactive(withAttributes: attributes, pushOut: pushOut)
        
        if case .animated(animation: let animation) = attributes.popBehavior, pushOut {
            animateOut(with: animation, outTranslationType: .pop)
        } else {
            animateOut(with: attributes.exitAnimation, outTranslationType: .exit)
        }
    }
    
    // Animate out
    private func animateOut(with animation: EKAttributes.Animation, outTranslationType: OutTranslation) {
        
        superview?.layoutIfNeeded()
        
        if let translation = animation.translate {
            performAnimation(out: true, with: translation) { [weak self] in
                self?.translateOut(withType: outTranslationType)
            }
        }
        
        if let fade = animation.fade {
            performAnimation(out: true, with: fade, preAction: { self.alpha = fade.start }) {
                self.alpha = fade.end
            }
        }
        
        if let scale = animation.scale {
            performAnimation(out: true, with: scale, preAction: { self.transform = CGAffineTransform(scaleX: scale.start, y: scale.start) }) {
                self.transform = CGAffineTransform(scaleX: scale.end, y: scale.end)
            }
        }

        if animation.containsAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + animation.maxDuration) {
                self.removeFromSuperview(keepWindow: false)
            }
        } else {
            translateOut(withType: outTranslationType)
            removeFromSuperview(keepWindow: false)
        }
    }
    
    // Animate in
    private func animateIn() {
                
        let animation = attributes.entranceAnimation
        
        superview?.layoutIfNeeded()
        
        if let translation = animation.translate {
            performAnimation(out: false, with: translation, action: translateIn)
        } else {
            translateIn()
        }
        
        if let fade = animation.fade {
            performAnimation(out: false, with: fade, preAction: { self.alpha = fade.start }) {
                self.alpha = fade.end
            }
        }
        
        if let scale = animation.scale {
            performAnimation(out: false, with: scale, preAction: { self.transform = CGAffineTransform(scaleX: scale.start, y: scale.start) }) {
                self.transform = CGAffineTransform(scaleX: scale.end, y: scale.end)
            }
        }
        
        entryDelegate?.changeToActive(withAttributes: attributes)
        
        // Execute didAppear action if needed
        if animation.containsAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + animation.maxDuration) {
                self.contentView.attributes.lifecycleEvents.didAppear?()
            }
        } else {
            contentView.attributes.lifecycleEvents.didAppear?()
        }
        
        scheduleAnimateOut()
    }
    
    // Translate in
    private func translateIn() {
        entranceOutConstraint.priority = .defaultLow
        exitOutConstraint.priority = .defaultLow
        popOutConstraint.priority = .defaultLow
        inConstraint.priority = .must
        superview?.layoutIfNeeded()
    }
    
    // Translate out
    private func translateOut(withType type: OutTranslation) {
        inConstraint.priority = .defaultLow
        entranceOutConstraint.priority = .defaultLow
        switch type {
        case .exit:
            exitOutConstraint.priority = .must
        case .pop:
            popOutConstraint.priority = .must
        case .swipeUp:
            swipeUpOutConstraint.priority = .must
        case .swipeDown:
            swipeDownOutConstraint.priority = .must
        }
        superview?.layoutIfNeeded()
    }
    
    // Perform animation - translate / scale / fade
    private func performAnimation(out: Bool, with animation: EKAnimation, preAction: @escaping () -> () = {}, action: @escaping () -> ()) {
        let curve: UIView.AnimationOptions = out ? .curveEaseIn : .curveEaseOut
        let options: UIView.AnimationOptions = [curve, .beginFromCurrentState]
        preAction()
        if let spring = animation.spring {
            UIView.animate(withDuration: animation.duration, delay: animation.delay, usingSpringWithDamping: spring.damping, initialSpringVelocity: spring.initialVelocity, options: options, animations: {
                action()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: animation.duration, delay: animation.delay, options: options, animations: {
                action()
            }, completion: nil)
        }
    }

    // MARK: Remvoe entry
    
    // Removes the view promptly - DOES NOT animate out
    func removePromptly(keepWindow: Bool = true) {
        outDispatchWorkItem?.cancel()
        entryDelegate?.changeToInactive(withAttributes: attributes, pushOut: false)
        contentView.content.attributes.lifecycleEvents.willDisappear?()
        removeFromSuperview(keepWindow: keepWindow)
    }
    
    // Remove self from superview
    func removeFromSuperview(keepWindow: Bool) {
        guard superview != nil else {
            return
        }
        
        // Execute didDisappear action if needed
        let didDisappear = contentView.content.attributes.lifecycleEvents.didDisappear

        // Remove the view from its superview and in a case of a view controller, from its parent controller.
        super.removeFromSuperview()
        contentView.content.viewController?.removeFromParent()
        
        entryDelegate.didFinishDisplaying(entry: contentView, keepWindowActive: keepWindow, dismissCompletionHandler: dismissHandler)
        
        // Lastly, perform the Dismiss Completion Handler as the entry is no longer displayed
        didDisappear?()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: Keyboard Logic
extension EKContentView {
    
    private enum KeyboardState {
        case visible
        case hidden
        
        var isVisible: Bool {
            return self == .visible
        }
        
        var isHidden: Bool {
            return self == .hidden
        }
    }
    
    private struct KeyboardAttributes {
        let duration: TimeInterval
        let curve: UIView.AnimationOptions
        let begin: CGRect
        let end: CGRect
        
        init?(withRawValue rawValue: [AnyHashable: Any]?) {
            guard let rawValue = rawValue else {
                return nil
            }
            duration = rawValue[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            curve = .init(rawValue: rawValue[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt)
            begin = (rawValue[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            end = (rawValue[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        }
        
        var height: CGFloat {
            return end.maxY - end.minY
        }
    }
    
    private func setupKeyboardChangeIfNeeded() {
        guard attributes.positionConstraints.keyboardRelation.isBound else {
            return
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    private func animate(by userInfo: [AnyHashable: Any]?, entrance: Bool) {
        
        // Guard that the entry is bound to the keyboard
        guard case .bind(offset: let offset) = attributes.positionConstraints.keyboardRelation else {
            return
        }
        
        // Convert the user info into keyboard attributes
        guard let keyboardAtts = KeyboardAttributes(withRawValue: userInfo) else {
            return
        }
        
        if entrance {
            inKeyboardConstraint.constant = -(keyboardAtts.height + offset.bottom)
            inKeyboardConstraint.priority = .must
            resistanceConstraint?.priority = .must
            inConstraint.priority = .defaultLow
        } else {
            inKeyboardConstraint.priority = .defaultLow
            resistanceConstraint?.priority = .defaultLow
            inConstraint.priority = .must
        }
        
        UIView.animate(withDuration: keyboardAtts.duration, delay: 0, options: keyboardAtts.curve, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard containsFirstResponder else {
            return
        }
        keyboardState = .visible
        animate(by: notification.userInfo, entrance: true)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        animate(by: notification.userInfo, entrance: false)
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        keyboardState = .hidden
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        guard containsFirstResponder else {
            return
        }
        animate(by: notification.userInfo, entrance: true)
    }
}

// MARK: Responds to user interactions (tap / pan / swipe / touches)
extension EKContentView {
    
    // Tap gesture handler
    @objc func tapGestureRecognized() {
        switch attributes.entryInteraction.defaultAction {
        case .delayExit(by: _) where attributes.displayDuration.isFinite:
            scheduleAnimateOut()
        case .dismissEntry:
            animateOut(pushOut: false)
        default:
            break
        }
        attributes.entryInteraction.customTapActions.forEach { $0() }
    }
    
    // Pan gesture handler
    @objc func panGestureRecognized(gr: UIPanGestureRecognizer) {
        guard keyboardState.isHidden else {
            return
        }
                
        // Delay the exit of the entry if needed
        handleExitDelayIfNeeded(byPanState: gr.state)
        
        let translation = gr.translation(in: superview!).y
        
        if shouldStretch(with: translation) {
            if attributes.scroll.isEdgeCrossingEnabled {
                totalTranslation += translation
                calculateLogarithmicOffset(forOffset: totalTranslation, currentTranslation: translation)
                
                switch gr.state {
                case .ended, .failed, .cancelled:
                    animateRubberBandPullback()
                default:
                    break
                }
            }
        } else {
            switch gr.state {
            case .ended, .failed, .cancelled:
                let velocity = gr.velocity(in: superview!).y
                swipeEnded(withVelocity: velocity)
            case .changed:
                inConstraint.constant += translation
            default:
                break
            }
        }
        gr.setTranslation(.zero, in: superview!)
    }

    private func swipeEnded(withVelocity velocity: CGFloat) {
        let distance = Swift.abs(inOffset - inConstraint.constant)
        var duration = max(0.3, TimeInterval(distance / Swift.abs(velocity)))
        duration = min(0.7, duration)
        
        if attributes.scroll.isSwipeable && testSwipeVelocity(with: velocity) && testSwipeInConstraint() {
            stretchOut(usingSwipe: velocity > 0 ? .swipeDown : .swipeUp, duration: duration)
        } else {
            animateRubberBandPullback()
        }
    }
    
    private func stretchOut(usingSwipe type: OutTranslation, duration: TimeInterval) {
        outDispatchWorkItem?.cancel()
        entryDelegate?.changeToInactive(withAttributes: attributes, pushOut: false)
        contentView.content.attributes.lifecycleEvents.willDisappear?()
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            self.translateOut(withType: type)
        }, completion: { finished in
            self.removeFromSuperview(keepWindow: false)
        })
    }
    
    private func calculateLogarithmicOffset(forOffset offset: CGFloat, currentTranslation: CGFloat) {
        guard verticalLimit != 0 else { return }
        if attributes.position.isTop {
            inConstraint.constant = verticalLimit * (1 + log10(offset / verticalLimit))
        } else {
            let offset = Swift.abs(offset) + verticalLimit
            let addition: CGFloat = abs(currentTranslation) < 2 ? 0 : 1
            inConstraint.constant -= (addition + log10(offset / verticalLimit))
        }
    }
    
    private func shouldStretch(with translation: CGFloat) -> Bool {
        if attributes.position.isTop {
            return translation > 0 && inConstraint.constant >= inOffset
        } else {
            return translation < 0 && inConstraint.constant <= inOffset
        }
    }
    
    private func animateRubberBandPullback() {
        totalTranslation = verticalLimit
    
        let animation: EKAttributes.Scroll.PullbackAnimation
        if case .enabled(swipeable: _, pullbackAnimation: let pullbackAnimation) = attributes.scroll {
            animation = pullbackAnimation
        } else {
            animation = .easeOut
        }

        UIView.animate(withDuration: animation.duration, delay: 0, usingSpringWithDamping: animation.damping, initialSpringVelocity: animation.initialSpringVelocity, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            self.inConstraint?.constant = self.inOffset
            self.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func testSwipeInConstraint() -> Bool {
        if attributes.position.isTop {
            return inConstraint.constant < inOffset
        } else {
            return inConstraint.constant > inOffset
        }
    }
    
    private func testSwipeVelocity(with velocity: CGFloat) -> Bool {
        if attributes.position.isTop {
            return velocity < -swipeMinVelocity
        } else {
            return velocity > swipeMinVelocity
        }
    }
    
    private func handleExitDelayIfNeeded(byPanState state: UIGestureRecognizer.State) {
        guard attributes.entryInteraction.isDelayExit && attributes.displayDuration.isFinite else {
            return
        }
        switch state {
        case .began:
            outDispatchWorkItem?.cancel()
        case .ended, .failed, .cancelled:
            scheduleAnimateOut()
        default:
            break
        }
    }
    
    // MARK: UIResponder
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if attributes.entryInteraction.isDelayExit && attributes.displayDuration.isFinite {
            outDispatchWorkItem?.cancel()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if attributes.entryInteraction.isDelayExit && attributes.displayDuration.isFinite {
            scheduleAnimateOut()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}
