//
//  ButtonsBarView.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/28/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class ButtonBarView: UIView {
    
    // MARK: Props
    private var topSeperatorView = UIView()
    private var midSeperatorView = UIView()
    private var closeButton = UIButton()
    private var approveButton = UIButton()
    
    var approveAction: (() -> ())!
    
    var buttonsContent: EKProperty.ButtonBarContent! {
        didSet {
            set(button: closeButton, with: buttonsContent.leading)
            set(button: approveButton, with: buttonsContent.trailing)
        }
    }
    
    // MARK: Setup
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        super.init(frame: .zero)
        setupTopSeperatorView()
        setupMidSeperatorView()
        setupCloseButton()
        setupApproveButton()
    }
    
    private func setupMidSeperatorView() {
        addSubview(midSeperatorView)
        midSeperatorView.set(.width, of: 1)
        midSeperatorView.layoutToSuperview(.top, .bottom, .centerX)
        midSeperatorView.backgroundColor = UIColor(white: 230.0/255.0, alpha: 1)
    }
    
    private func setupTopSeperatorView() {
        addSubview(topSeperatorView)
        topSeperatorView.set(.height, of: 1)
        topSeperatorView.layoutToSuperview(.left, .right, .top)
        topSeperatorView.backgroundColor = UIColor(white: 230.0/255.0, alpha: 1)
    }
    
    private func setupCloseButton() {
        addSubview(closeButton)
        closeButton.layoutToSuperview(.bottom, .leading)
        closeButton.layout(.top, to: .bottom, of: topSeperatorView)
        closeButton.layout(.trailing, to: .leading, of: midSeperatorView)
        closeButton.addTarget(self, action: #selector(closeButtonTouchUpInside), for: .touchUpInside)
        addEvents(to: closeButton)
    }
    
    private func setupApproveButton() {
        addSubview(approveButton)
        approveButton.layoutToSuperview(.bottom, .trailing)
        approveButton.layout(.top, to: .bottom, of: topSeperatorView)
        approveButton.layout(.leading, to: .trailing, of: midSeperatorView)
        approveButton.addTarget(self, action: #selector(approveButtonTouchUpInside), for: .touchUpInside)
        addEvents(to: approveButton)
    }

    private func set(button: UIButton, with content: EKProperty.ButtonContent) {
        button.setTitle(content.label.text, for: .normal)
        button.setTitleColor(content.label.style.color, for: .normal)
        button.titleLabel?.font = content.label.style.font
        button.backgroundColor = content.backgroundColor
    }
    
    private func addEvents(to button: UIButton) {
        button.addTarget(self, action: #selector(buttonTouchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
    }
    
    private func setBackground(for button: UIButton, by content: EKProperty.ButtonContent) {
        button.backgroundColor = content.backgroundColor
    }
    
    // MARK: Actions
    
    @objc func closeButtonTouchUpInside() {
        SwiftEntryKit.dismiss()
    }
    
    @objc func approveButtonTouchUpInside() {
        approveAction?()
    }
    
    @objc func buttonTouchDown(_ button: UIButton) {
        button.backgroundColor = button.titleColor(for: .normal)!.withAlphaComponent(0.05)
    }
    
    @objc func buttonTouchUp(_ button: UIButton) {
        setBackground(for: button, by: button == closeButton ? buttonsContent.leading : buttonsContent.trailing)
    }
}
