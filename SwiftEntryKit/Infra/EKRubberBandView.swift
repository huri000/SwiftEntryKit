//
//  EKScrollView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

protocol EntryScrollViewDelegate: class {
    func changeToActive(withAttributes attributes: EKAttributes)
    func changeToInactive(withAttributes attributes: EKAttributes)
}

class EKRubberBandView: UIView {
    
    enum OutTranslation {
        case exit
        case pop
        case swipe
    }
    
    // MARK: Props
    
    // Entry delegate
    private weak var entryDelegate: EntryScrollViewDelegate!
    
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
    
    init(withEntryDelegate entryDelegate: EntryScrollViewDelegate) {
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
        let messageAnchorInSuperview: NSLayoutAttribute
        let messageTopInSuperview: NSLayoutAttribute
        inOffset = 0
        var outOffset: CGFloat = 0
        
        var totalEntryHeight: CGFloat = 0
        
        // Define a spacer to catch top / bottom offsets
        var spacerView: UIView!
        let safeAreaInsets = EKWindowProvider.safeAreaInsets
        let overrideSafeArea = attributes.positionConstraints.safeArea.isOverriden
        
        if !overrideSafeArea && safeAreaInsets.hasVerticalInsets {
            spacerView = UIView()
            addSubview(spacerView)
            spacerView.set(.height, of: safeAreaInsets.top)
            spacerView.layoutToSuperview(.width, .centerX)
            
            totalEntryHeight += safeAreaInsets.top
        }
        
        switch attributes.position {
        case .top:
            messageAnchorInSuperview = .top
            messageTopInSuperview = .bottom
            
            if overrideSafeArea {
                if #available(iOS 11.0, *) {
                    inOffset = -safeAreaInsets.top
                } else {
                    inOffset = 0
                }
            } else {
                inOffset = safeAreaInsets.top
            }
            
            inOffset += attributes.positionConstraints.verticalOffset
            outOffset = -safeAreaInsets.top
            
            spacerView?.layout(.bottom, to: .top, of: self)
            
        case .bottom:
            messageAnchorInSuperview = .bottom
            messageTopInSuperview = .top
            
            inOffset = -safeAreaInsets.bottom - attributes.positionConstraints.verticalOffset
            
            spacerView?.layout(.top, to: .bottom, of: self)
        }
        
        // Layout the content view inside the scroll view
        addSubview(contentView)
        contentView.layoutToSuperview(.left, .right, .top, .bottom)
        contentView.layoutToSuperview(.width, .height)
        
        // Setup out constraint, capture pre calculated offsets and attributes
        let setupOutConstraint = { (animation: EKAttributes.Animation, priority: UILayoutPriority) -> NSLayoutConstraint in
            let constraint: NSLayoutConstraint
            if animation.containsTranslation {
                constraint = self.layout(messageTopInSuperview, to: messageAnchorInSuperview, of: self.superview!, offset: outOffset, priority: priority)!
            } else {
                constraint = self.layout(to: messageAnchorInSuperview, of: self.superview!, offset: self.inOffset, priority: priority)!
            }
            return constraint
        }
        
        if case .animated(animation: let animation) = attributes.popBehavior {
            popOutConstraint = setupOutConstraint(animation, .defaultLow)
        } else {
            popOutConstraint = layout(to: messageAnchorInSuperview, of: superview!, offset: inOffset, priority: .defaultLow)!
        }
        
        // Set position constraints
        entranceOutConstraint = setupOutConstraint(attributes.entranceAnimation, .must)
        exitOutConstraint = setupOutConstraint(attributes.exitAnimation, .defaultLow)
        inConstraint = layout(to: messageAnchorInSuperview, of: superview!, offset: inOffset, priority: .defaultLow)
        outConstraint = layout(messageTopInSuperview, to: messageAnchorInSuperview, of: superview!, offset: outOffset, priority: .defaultLow)

        totalTranslation = inOffset
        if attributes.position.isTop {
            verticalLimit = inOffset
        } else {
            verticalLimit = UIScreen.main.bounds.height + inOffset
        }
    }
    
    // Setup layout constraints according to EKAttributes.PositionConstraints
    private func setupLayoutConstraints() {
        
        layoutToSuperview(.centerX)
        
        // Layout the scroll view horizontally inside the screen
        switch attributes.positionConstraints.width {
        case .offset(value: let offset):
            layoutToSuperview(axis: .horizontally, offset: offset, priority: .must)
        case .ratio(value: let ratio):
            layoutToSuperview(.width, ratio: ratio, priority: .must)
        case .constant(value: let constant):
            set(.width, of: constant, priority: .must)
        case .unspecified:
            break
        }
        
        // Layout the scroll view vertically inside the screen
        switch attributes.positionConstraints.height {
        case .offset(value: let offset):
            layoutToSuperview(.height, offset: -offset)
        case .ratio(value: let ratio):
            layoutToSuperview(.height, ratio: ratio)
        case .constant(value: let constant):
            set(.height, of: constant)
        case .unspecified:
            break
        }
        
        // Layout the scroll view according to the maximum width (if given any)
        switch attributes.positionConstraints.maximumWidth {
        case .offset(value: let offset):
            layout(to: .left, of: superview!, relation: .greaterThanOrEqual, offset: offset)
            layout(to: .right, of: superview!, relation: .lessThanOrEqual, offset: -offset)
        case .ratio(value: let ratio):
            layoutToSuperview(.centerX)
            layout(to: .width, of: superview!, relation: .lessThanOrEqual, ratio: ratio)
        case .constant(value: let constant):
            set(.width, of: constant, relation: .lessThanOrEqual)
            break
        case .unspecified:
            break
        }
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
        guard #available(iOS 10.0, *), attributes.generateHapticFeedback else {
            return
        }
        HapticFeedbackGenerator.notification(type: .success)
    }
    
    // MARK: Animations
    
    // Schedule out animation
    private func scheduleAnimateOut(withDelay delay: TimeInterval? = nil) {
        outDispatchWorkItem?.cancel()
        outDispatchWorkItem = DispatchWorkItem { [weak self] in
            self?.animateOut(pushOut: false)
        }
        let delay = attributes.entranceAnimation.duration + (delay ?? attributes.displayDuration)
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
        let duration = animation.duration
        let options: UIViewAnimationOptions = [.curveEaseOut, .beginFromCurrentState]
        var shouldAnimate = false
        
        superview?.layoutIfNeeded()
        if animation.containsTranslation {
            shouldAnimate = true
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                self.translateOut(withType: outTranslationType)
            }, completion: { finished in
                self.removeFromSuperview(keepWindow: false)
            })
        }

        // Get fade
        if let fadeAnimation = animation.fade, case EKAttributes.Animation.AnimationType.fade(from: let start, to: let end) = fadeAnimation {
            shouldAnimate = true
            fade(fromAlpha: start, toAlpha: end, duration: duration) { [weak self] in
                self?.removeFromSuperview(keepWindow: false)
            }
        }

        // Get scale
        if let scale = animation.scale, case EKAttributes.Animation.AnimationType.scale(from: let start, to: let end) = scale {
            shouldAnimate = true
            transform(fromScale: start, toScale: end, duration: duration) { [weak self] in
                self?.removeFromSuperview(keepWindow: false)
            }
        }
        
        if !shouldAnimate {
            translateOut(withType: outTranslationType)
            removeFromSuperview(keepWindow: false)
        }
    }
    
    // Animate in
    private func animateIn() {
        
        EKAttributes.count += 1
        
        let animation = attributes.entranceAnimation
        let duration = animation.duration
        let options: UIViewAnimationOptions = [.curveEaseOut, .beginFromCurrentState]
        
        // Change to active state
        superview?.layoutIfNeeded()
        if !animation.containsTranslation {
            translateIn()
        } else {
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                self.translateIn()
            }, completion: nil)
        }
        
        // Get fade
        if let fadeAnimation = animation.fade, case EKAttributes.Animation.AnimationType.fade(from: let start, to: let end) = fadeAnimation {
            fade(fromAlpha: start, toAlpha: end, duration: duration)
        }

        // Get scale
        if let scale = animation.scale, case EKAttributes.Animation.AnimationType.scale(from: let start, to: let end) = scale {
            transform(fromScale: start, toScale: end, duration: duration)
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
    
    // Fade animation
    private func fade(fromAlpha start: CGFloat, toAlpha end: CGFloat, duration: TimeInterval, completion: @escaping () -> () = {}) {
        alpha = start
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.alpha = end
        }, completion: { finished in
            completion()
        })
    }
    
    // Scale animation
    private func transform(fromScale start: CGFloat, toScale end: CGFloat, duration: TimeInterval, completion: @escaping () -> () = {}) {
        transform = CGAffineTransform(scaleX: start, y: start)
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.transform = CGAffineTransform(scaleX: end, y: end)
        }, completion: { finished in
            completion()
        })
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
extension EKRubberBandView {
    
    // Tap gesture handler
    @objc func tapGestureRecognized() {
        switch attributes.entryInteraction.defaultAction {
        case .delayExit(by: _):
            scheduleAnimateOut()
        case .dismissEntry:
            animateOut(pushOut: false)
        default:
            break
        }
        attributes.entryInteraction.customActions.forEach { $0() }
    }
    
    // Pan gesture handler
    @objc func panGestureRecognized(gr: UIPanGestureRecognizer) {
        
        // Delay the exit of the entry if needed
        handleExitDelayIfNeeded(byPanState: gr.state)
        
        let translation = gr.translation(in: superview!).y
        
        if shouldStretch(with: translation) {
            if attributes.scroll.isEdgeCrossingEnabled {
                totalTranslation += translation
                calculateLogarithmicOffset(forOffset: totalTranslation)
                
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
        let duration = max(0.3, TimeInterval(distance / Swift.abs(velocity)))
                
        if attributes.scroll.isSwipeable && testSwipeVelocity(with: velocity) && testSwipeInConstraint() {
            stretchOut(duration: duration)
        } else {
            animateRubberBandPullback()
        }
    }
    
    private func stretchOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            self.translateOut(withType: .swipe)
        }, completion: { finished in
            self.removeFromSuperview(keepWindow: false)
        })
    }
    
    private func calculateLogarithmicOffset(forOffset offset: CGFloat) {
        if attributes.position.isTop {
            inConstraint.constant = verticalLimit * (1 + log10(offset / verticalLimit))
        } else {
            let offset = Swift.abs(offset) + verticalLimit
            inConstraint.constant -= (1 + log10(offset / verticalLimit))
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
        
        var damping: CGFloat = 1
        var duration: TimeInterval = 0.3
        if case EKAttributes.Scroll.enabled(swipeable: _, springWithDamping: let springWithDamping) = attributes.scroll {
            if springWithDamping {
                damping = 0.3
                duration = 0.5
            }
        }

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 10, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
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
        guard attributes.entryInteraction.isDelayExit else {
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
        if attributes.entryInteraction.isDelayExit {
            outDispatchWorkItem?.cancel()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if attributes.entryInteraction.isDelayExit {
            scheduleAnimateOut()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}
