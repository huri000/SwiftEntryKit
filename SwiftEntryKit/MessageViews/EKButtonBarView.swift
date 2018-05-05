//
//  ButtonsBarView.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/28/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout

/**
 Dynamic button bar view
 Buttons are set according to the received content.
 1-2 buttons spread horizontally
 3 or more buttons spread vertically
 */
public class EKButtonBarView: UIView {
    
    // MARK: Props
    private var buttons: [UIButton] = []
    
    private let buttonBarContent: EKProperty.ButtonBarContent
    private let spreadAxis: QLAxis
    private let oppositeAxis: QLAxis
    private let relativeEdge: NSLayoutAttribute
    
    private lazy var buttonEdgeRatio: CGFloat = {
        return 1.0 / CGFloat(self.buttonBarContent.content.count)
    }()
    
    private(set) lazy var intrinsicHeight: CGFloat = {
        let buttonHeight: CGFloat = 50
        let height: CGFloat
        switch buttonBarContent.content.count {
        case 0:
            height = 1
        case 1, 2:
            height = buttonHeight
        default:
            height = buttonHeight * CGFloat(buttons.count)
        }
        return height
    }()
    
    private var compressedConstraint: NSLayoutConstraint!
    private var expandedConstraint: NSLayoutConstraint!

    // MARK: Setup
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(with buttonBarContent: EKProperty.ButtonBarContent) {
        self.buttonBarContent = buttonBarContent
        if buttonBarContent.content.count <= 2 {
            spreadAxis = .horizontally
            oppositeAxis = .vertically
            relativeEdge = .width
        } else {
            spreadAxis = .vertically
            oppositeAxis = .horizontally
            relativeEdge = .height
        }
        super.init(frame: .zero)
        setupButtonBarContent()
        setupSeparatorViews()
        
        compressedConstraint = set(.height, of: 1, priority: .must)
        expandedConstraint = set(.height, of: intrinsicHeight, priority: .defaultLow)
    }
    
    private func setupButtonBarContent() {
        for (index, buttonContent) in buttonBarContent.content.enumerated() {
            setButton(for: buttonContent, index: index)
        }
        layoutButtons()
    }
    
    private func layoutButtons() {
        guard !buttons.isEmpty else {
            return
        }
        buttons.layoutToSuperview(axis: oppositeAxis)
        buttons.spread(spreadAxis, stretchEdgesToSuperview: true)
        buttons.layout(relativeEdge, to: self, ratio: buttonEdgeRatio, priority: .must)
    }
    
    private func setupTopSeperatorView() {
        let topSeparatorView = UIView()
        addSubview(topSeparatorView)
        topSeparatorView.set(.height, of: 1)
        topSeparatorView.layoutToSuperview(.left, .right, .top)
        topSeparatorView.backgroundColor = buttonBarContent.separatorColor
    }
    
    private func setupSeperatorView(after button: UIButton) {
        let midSepView = UIView()
        addSubview(midSepView)
        let sepAttribute: NSLayoutAttribute
        let buttonAtt: NSLayoutAttribute
        switch oppositeAxis {
        case .vertically:
            sepAttribute = .centerX
            buttonAtt = .right
        case .horizontally:
            sepAttribute = .centerY
            buttonAtt = .bottom
        }
        midSepView.layout(sepAttribute, to: buttonAtt, of: button)
        midSepView.set(relativeEdge, of: 1)
        midSepView.layoutToSuperview(axis: oppositeAxis)
        midSepView.backgroundColor = buttonBarContent.separatorColor
    }
    
    private func setupSeparatorViews() {
        setupTopSeperatorView()
        for button in buttons.dropLast() {
            setupSeperatorView(after: button)
        }
    }
    
    // MARK: Setup Buttons
    private func setButton(for content: EKProperty.ButtonContent, index: Int) {
        let button = UIButton()
        button.tag = index
        addEvents(to: button)
        set(button: button, with: content)
        addSubview(button)
        buttons.append(button)
    }
    
    // Style & Text
    private func set(button: UIButton, with content: EKProperty.ButtonContent) {
        button.setTitle(content.label.text, for: .normal)
        button.setTitleColor(content.label.style.color, for: .normal)
        button.titleLabel?.font = content.label.style.font
        button.backgroundColor = content.backgroundColor
    }
    
    private func setBackground(for button: UIButton, by content: EKProperty.ButtonContent) {
        button.backgroundColor = content.backgroundColor
    }
    
    // Add Selectors
    private func addEvents(to button: UIButton) {
        button.addTarget(self, action: #selector(buttonTouchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
    }
    
    // Amination
    func expand() {
        compressedConstraint.priority = .defaultLow
        expandedConstraint.priority = .must
    }
    
    func compress() {
        compressedConstraint.priority = .must
        expandedConstraint.priority = .defaultLow
    }

    // MARK: Buttons Selectors
    @objc func buttonTouchUpInside(_ button: UIButton) {
        buttonBarContent.content[button.tag].action?()
    }
    
    @objc func buttonTouchDown(_ button: UIButton) {
        button.backgroundColor = button.titleColor(for: .normal)!.withAlphaComponent(0.05)
    }
    
    @objc func buttonTouchUp(_ button: UIButton) {
        setBackground(for: button, by: buttonBarContent.content[button.tag])
    }
}
