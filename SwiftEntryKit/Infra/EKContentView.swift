//
//  EKScrollView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

protocol EntryContentViewDelegate: class {
    func changeToActive(withAttributes attributes: EKAttributes)
    func changeToInactive(withAttributes attributes: EKAttributes)
}

class EKContentView: UIView {
    
    enum OutTranslation {
        case exit
        case pop
        case swipe
    }
    
    // MARK: Props
    
    // Entry delegate
    private weak var entryDelegate: EntryContentViewDelegate!
    
    // Constraints and Offsets
    private var entranceOutConstraint: NSLayoutConstraint!
    private var exitOutConstraint: NSLayoutConstraint!
    private var popOutConstraint: NSLayoutConstraint!
    private var inConstraint: NSLayoutConstraint!
    private var outConstraint: NSLayoutConstraint!
    
    private var inOffset: CGFloat = 0
    private var totalTranslation: CGFloat = 0
    private var verticalLimit: CGFloat = 0
    private let swipeMinVelocity: CGFloat = 60
    
    private var outDispatchWorkItem: DispatchWorkItem!

    // Data source
    private var attributes: EKAttributes!
    
    // Content
    private var contentView: UIView!
    
    // MARK: Setup
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withEntryDelegate entryDelegate: EntryContentViewDelegate) {
        self.entryDelegate = entryDelegate
        super.init(frame: .zero)
    }
    
    // Called from outer scope with a presentable view and attributes
    func setup(with contentView: UIView, attributes: EKAttributes) {
        
        self.attributes = attributes
        self.contentView = contentView
        
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
    }
    
    // Setup the scrollView initial position
    private func setupInitialPosition() {
        
        // Determine the layout entrance type according to the entry type
        let messageInAnchor: NSLayoutAttribute
        let screenOutAnchor: NSLayoutAttribute
        let messageOutAnchor: NSLayoutAttribute
        inOffset = 0
        var outOffset: CGFloat = 0
        
        var totalEntryHeight: CGFloat = 0
        
        // Define a spacer to catch top / bottom offsets
        var spacerView: UIView!
        let safeAreaInsets = EKWindowProvider.safeAreaInsets
        let overrideSafeArea = attributes.positionConstraints.safeArea.isOverriden
        
        if !overrideSafeArea && safeAreaInsets.hasVerticalInsets && !attributes.position.isCenter {
            spacerView = UIView()
            addSubview(spacerView)
            spacerView.set(.height, of: safeAreaInsets.top)
            spacerView.layoutToSuperview(.width, .centerX)
            
            totalEntryHeight += safeAreaInsets.top
        }
        
        switch attributes.position {
        case .top:
            screenOutAnchor = .top
            messageOutAnchor = .bottom
            messageInAnchor = .top
            
            inOffset = overrideSafeArea ? 0 : safeAreaInsets.top

            inOffset += attributes.positionConstraints.verticalOffset
            outOffset = -safeAreaInsets.top
            
            spacerView?.layout(.bottom, to: .top, of: self)
        case .bottom:
            screenOutAnchor = .bottom
            messageOutAnchor = .top
            messageInAnchor = .bottom
            
            inOffset = -safeAreaInsets.bottom - attributes.positionConstraints.verticalOffset
            
            spacerView?.layout(.top, to: .bottom, of: self)
        case .center:
            screenOutAnchor = .bottom
            messageOutAnchor = .top
            messageInAnchor = .centerY
        }
        
        // Layout the content view inside the scroll view
        addSubview(contentView)
        contentView.layoutToSuperview(.left, .right, .top, .bottom)
        contentView.layoutToSuperview(.width, .height)
        
        // Setup out constraint, capture pre calculated offsets and attributes
        let setupOutConstraint = { (animation: EKAttributes.Animation, priority: UILayoutPriority) -> NSLayoutConstraint in
            let constraint: NSLayoutConstraint
            if animation.containsTranslation {
                constraint = self.layout(messageOutAnchor, to: screenOutAnchor, of: self.superview!, offset: outOffset, priority: priority)!
            } else {
                constraint = self.layout(to: messageInAnchor, of: self.superview!, offset: self.inOffset, priority: priority)!
            }
            return constraint
        }
        
        if case .animated(animation: let animation) = attributes.popBehavior {
            popOutConstraint = setupOutConstraint(animation, .defaultLow)
        } else {
            popOutConstraint = layout(to: messageInAnchor, of: superview!, offset: inOffset, priority: .defaultLow)!
        }
        
        // Set position constraints
        entranceOutConstraint = setupOutConstraint(attributes.entranceAnimation, .must)
        exitOutConstraint = setupOutConstraint(attributes.exitAnimation, .defaultLow)
        inConstraint = layout(to: messageInAnchor, of: superview!, offset: inOffset, priority: .defaultLow)
        outConstraint = layout(messageOutAnchor, to: screenOutAnchor, of: superview!, offset: outOffset, priority: .defaultLow)

        totalTranslation = inOffset
        switch attributes.position {
        case .top:
            verticalLimit = inOffset
        case .bottom, .center:
            verticalLimit = UIScreen.main.bounds.height + inOffset
        }
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
        guard attributes.entryInteraction.isResponsive else {
            return
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
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
        outDispatchWorkItem?.cancel()
        entryDelegate?.changeToInactive(withAttributes: attributes)
        
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
            performAnimation(with: translation) { [weak self] in
                self?.translateOut(withType: outTranslationType)
            }
        }
        
        if let fade = animation.fade {
            performAnimation(with: fade, preAction: { self.alpha = fade.start }) {
                self.alpha = fade.end
            }
        }
        
        if let scale = animation.scale {
            performAnimation(with: scale, preAction: { self.transform = CGAffineTransform(scaleX: scale.start, y: scale.start) }) {
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
        
        EKAttributes.count += 1
        
        let animation = attributes.entranceAnimation
        
        superview?.layoutIfNeeded()
        
        if let translation = animation.translate {
            performAnimation(with: translation, action: translateIn)
        } else {
            translateIn()
        }
        
        if let fade = animation.fade {
            performAnimation(with: fade, preAction: { self.alpha = fade.start }) {
                self.alpha = fade.end
            }
        }
        
        if let scale = animation.scale {
            performAnimation(with: scale, preAction: { self.transform = CGAffineTransform(scaleX: scale.start, y: scale.start) }) {
                self.transform = CGAffineTransform(scaleX: scale.end, y: scale.end)
            }
        }
                
        entryDelegate?.changeToActive(withAttributes: attributes)

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
        case .swipe:
            outConstraint.priority = .must
        }
        superview?.layoutIfNeeded()
    }
    
    // Perform animation - translate / scale / fade
    private func performAnimation(with animation: EKAnimation, preAction: @escaping () -> () = {}, action: @escaping () -> ()) {
        let options: UIViewAnimationOptions = [.curveEaseOut, .beginFromCurrentState]
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
        entryDelegate?.changeToInactive(withAttributes: attributes)
        removeFromSuperview(keepWindow: keepWindow)
    }
    
    // Remove self from superview
    func removeFromSuperview(keepWindow: Bool) {
        guard let _ = superview else {
            return
        }
        super.removeFromSuperview()
        if EKAttributes.count > 0 {
            EKAttributes.count -= 1
        }
        if !keepWindow && !EKAttributes.isPresenting {
            EKWindowProvider.shared.state = .main
        }
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
            stretchOut(duration: duration)
        } else {
            animateRubberBandPullback()
        }
    }
    
    private func stretchOut(duration: TimeInterval) {
        outDispatchWorkItem?.cancel()
        entryDelegate?.changeToInactive(withAttributes: attributes)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            self.translateOut(withType: .swipe)
        }, completion: { finished in
            self.removeFromSuperview(keepWindow: false)
        })
    }
    
    private func calculateLogarithmicOffset(forOffset offset: CGFloat, currentTranslation: CGFloat) {
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
        if case EKAttributes.Scroll.enabled(swipeable: _, pullbackAnimation: let pullbackAnimation) = attributes.scroll {
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
    
    private func handleExitDelayIfNeeded(byPanState state: UIGestureRecognizerState) {
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
