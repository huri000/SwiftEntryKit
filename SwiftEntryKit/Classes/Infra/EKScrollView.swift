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

class EKScrollView: UIScrollView {

    // MARK: Props
    
    // Entry delegate
    private weak var entryDelegate: EntryScrollViewDelegate!
    
    // Constraints
    private var entranceOutConstraint: NSLayoutConstraint!
    private var inConstraint: NSLayoutConstraint!
    private var exitOutConstraint: NSLayoutConstraint!
    
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
        makeHapticFeedback()
    }
    
    private func setupInitialPosition() {
        
        // Determine the layout entrance type according to the entry type
        let messageBottomInSuperview: NSLayoutAttribute
        let messageTopInSuperview: NSLayoutAttribute
        var inOffset: CGFloat = 0
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
            messageBottomInSuperview = .top
            messageTopInSuperview = .bottom
            
            if overrideSafeArea {
                inOffset = -safeAreaInsets.top
            } else {
                inOffset = safeAreaInsets.top
            }
            
            inOffset += attributes.positionConstraints.verticalOffset
            outOffset = -safeAreaInsets.top
            
            spacerView?.layout(.bottom, to: .top, of: self)
            
        case .bottom:
            messageBottomInSuperview = .bottom
            messageTopInSuperview = .top
            
            inOffset = -safeAreaInsets.bottom - attributes.positionConstraints.verticalOffset
            
            spacerView?.layout(.top, to: .bottom, of: self)
        }
        
        // Layout the content view inside the scroll view
        addSubview(contentView)
        contentView.layoutToSuperview(.left, .right, .top, .bottom, .width, .height)
        
        // Setup out constraint, capture pre calculated offsets and attributes
        let setupOutConstraint = { (animation: EKAttributes.Animation, priority: UILayoutPriority) -> NSLayoutConstraint in
            let constraint: NSLayoutConstraint
            if animation.containsTranslation {
                constraint = self.layout(messageTopInSuperview, to: messageBottomInSuperview, of: self.superview!, offset: outOffset, priority: .must)!
            } else {
                constraint = self.layout(to: messageBottomInSuperview, of: self.superview!, offset: inOffset, priority: .must)!
            }
            return constraint
        }
        
        // Set position constraints
        entranceOutConstraint = setupOutConstraint(attributes.entranceAnimation, .must)
        exitOutConstraint = setupOutConstraint(attributes.exitAnimation, .defaultLow)
        inConstraint = layout(to: messageBottomInSuperview, of: superview!, offset: inOffset, priority: .defaultLow)
    }
    
    // Setup layout constraints
    private func setupLayoutConstraints() {
        
        // Layout the scroll view horizontally inside the screen
        switch attributes.positionConstraints.width {
        case .offset(value: let offset):
            layoutToSuperview(axis: .horizontally, offset: offset, priority: .must)
        case .ratio(value: let ratio):
            layoutToSuperview(.centerX)
            layoutToSuperview(.width, ratio: ratio, priority: .must)
        case .constant(value: let constant):
            set(.width, of: constant, priority: .must)
        case .unspecified:
            break
        }
        
        // Layout the height
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
        
        switch attributes.positionConstraints.maximumWidth {
        case .offset(value: let offset):
            layout(to: .left, of: superview!, relation: .greaterThanOrEqual, offset: offset)
            layout(to: .right, of: superview!, relation: .lessThanOrEqual, offset: -offset)
        case .ratio(value: let ratio):
            layoutToSuperview(.centerX)
            layout(to: .width, of: superview!, relation: .lessThanOrEqual, ratio: ratio)
        case .constant(value: let constant):
            // TODO: Add relation to QuickLayout
//            set(.width, of: constant, relation: .lessThanOrEqual)
            break
        case .unspecified:
            break
        }
    }

    private func setupAttributes() {
        clipsToBounds = false
        alwaysBounceVertical = true
        bounces = true
        showsVerticalScrollIndicator = false
        isPagingEnabled = true
        delegate = self
        isScrollEnabled = attributes.options.scroll.isLooselyEnabled
    }
    
    private func setupTapGestureRecognizer() {
        guard attributes.entryInteraction.isResponsive else {
            return
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func makeHapticFeedback() {
        guard #available(iOS 10.0, *), attributes.options.useHapticFeedback else {
            return
        }
        HapticFeedbackGenerator.notification(type: .success)
    }
    
    // MARK: State Change / Animations
    private func changeToActiveState() {
        entranceOutConstraint.priority = .defaultLow
        exitOutConstraint.priority = .defaultLow
        inConstraint.priority = .must
        superview?.layoutIfNeeded()
    }
    
    private func changeToInactiveState() {
        inConstraint.priority = .defaultLow
        entranceOutConstraint.priority = .defaultLow
        exitOutConstraint.priority = .must
        superview?.layoutIfNeeded()
    }
    
    func removeFromSuperview(keepWindow: Bool) {
        super.removeFromSuperview()
        if EKAttributes.count > 0 {
            EKAttributes.count -= 1
        }
        if !keepWindow && !EKAttributes.isPresenting {
            EKWindowProvider.shared.state = .main
        }
    }
    
    func animateOut(pushOut: Bool) {
        outDispatchWorkItem?.cancel()
        entryDelegate?.changeToInactive(withAttributes: attributes)
        
        if case .animated(animation: let animation) = attributes.options.popBehavior, pushOut {
            animateOut(with: animation)
        } else {
            animateOut(with: attributes.exitAnimation)
        }
    }
    
    private func animateOut(with animation: EKAttributes.Animation) {
        let duration = animation.duration
        let options: UIViewAnimationOptions = [.curveEaseOut, .beginFromCurrentState]
        
        // Change to active state
        superview?.layoutIfNeeded()
        if !animation.containsTranslation {
            changeToInactiveState()
        } else {
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                self.changeToInactiveState()
            }, completion: { finished in
                self.removeFromSuperview(keepWindow: false)
            })
        }
        
        // Get fade
        if let fadeAnimation = animation.fade, case EKAttributes.Animation.AnimationType.fade(from: let start, to: let end) = fadeAnimation {
            fade(fromAlpha: end, toAlpha: start, duration: duration)
        }
        
        // Get scale
        if let scale = animation.scale, case EKAttributes.Animation.AnimationType.scale(from: let start, to: let end) = scale {
            transform(fromScale: end, toScale: start, duration: duration)
        }
    }
    
    private func rollOut() {
        
    }
    
    private func scheduleAnimateOut(withDelay delay: TimeInterval? = nil) {
        outDispatchWorkItem?.cancel()
        outDispatchWorkItem = DispatchWorkItem { [weak self] in
            self?.animateOut(pushOut: false)
        }
        let delay = attributes.entranceAnimation.duration + (delay ?? attributes.displayDuration)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: outDispatchWorkItem)
    }
    
    private func animateIn() {
        
        // Increment entry count
        EKAttributes.count += 1
    
        let animation = attributes.entranceAnimation
        let duration = animation.duration
        let options: UIViewAnimationOptions = [.curveEaseOut, .beginFromCurrentState]
        
        // Change to active state
        superview?.layoutIfNeeded()
        if !animation.containsTranslation {
            changeToActiveState()
        } else {
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                self.changeToActiveState()
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
    
    private func fade(fromAlpha start: CGFloat, toAlpha end: CGFloat, duration: TimeInterval) {
        alpha = start
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.alpha = end
        }, completion: nil)
    }
    
    private func transform(fromScale start: CGFloat, toScale end: CGFloat, duration: TimeInterval) {
        transform = CGAffineTransform(scaleX: start, y: start)
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.transform = CGAffineTransform(scaleX: end, y: end)
        }, completion: nil)
    }
    
    // Removes the view promptly - DOES NOT animate out
    func removePromptly(keepWindow: Bool = true) {
        outDispatchWorkItem?.cancel()
        entryDelegate?.changeToInactive(withAttributes: attributes)
        removeFromSuperview(keepWindow: keepWindow)
    }
    
    // MARK: Tap Gesture Handler
    @objc func tapGestureRecognized() {
        switch attributes.entryInteraction.defaultAction {
        case .dismissEntry:
            animateOut(pushOut: true)
            fallthrough
        default:
            attributes.entryInteraction.customActions.forEach { $0() }
        }
    }
}

// MARK: UIScrollViewDelegate
extension EKScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let scrollAttribute = attributes?.options.scroll, scrollAttribute.isEdgeCrossingDisabled else {
            return
        }
        if attributes.position.isTop && contentOffset.y < 0 {
            contentOffset.y = 0
        } else if !attributes.position.isTop && scrollView.bounds.maxY > scrollView.contentSize.height {
            contentOffset.y = 0
        }
    }
}

// MARK: UIResponder
extension EKScrollView {
    
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
