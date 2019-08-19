//
//  EKFormMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/15/18.
//

import UIKit

final public class EKFormMessageView: UIView {
    
    private let scrollViewVerticalOffset: CGFloat = 20
    
    // MARK: Props
    
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let textFieldsContent: [EKProperty.TextFieldContent]
    private let textViewsContent: [EKProperty.TextViewContent]
    private var textFieldViews: [EKTextField] = []
    private var textViewViews: [EKTextView] = []
    private var buttonBarView: EKButtonBarView!
    
    private let titleContent: EKProperty.LabelContent
    
    // MARK: Setup
    
    public convenience init(with title: EKProperty.LabelContent,
                textFieldsContent: [EKProperty.TextFieldContent],
                buttonContent: EKProperty.ButtonContent) {
        self.init(with: title, textFieldsContent: textFieldsContent, textViewsContent: [], buttonContent: buttonContent)
    }
    
    public init(with title: EKProperty.LabelContent,
                textFieldsContent: [EKProperty.TextFieldContent],
                textViewsContent: [EKProperty.TextViewContent],
                buttonContent: EKProperty.ButtonContent) {
        self.titleContent = title
        self.textFieldsContent = textFieldsContent
        self.textViewsContent = textViewsContent
        super.init(frame: UIScreen.main.bounds)
        setupScrollView()
        setupTitleLabel()
        setupTextFields(with: textFieldsContent)
        setupTextViews(with: textViewsContent)
        setupButton(with: buttonContent)
        setupTapGestureRecognizer()
        scrollView.layoutIfNeeded()
        set(.height,
            of: scrollView.contentSize.height + scrollViewVerticalOffset * 2,
            priority: .defaultHigh)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextFields(with textFieldsContent: [EKProperty.TextFieldContent]) {
        var textFieldIndex = 0
        textFieldViews = textFieldsContent.map { content -> EKTextField in
            let textField = EKTextField(with: content)
            scrollView.addSubview(textField)
            textField.tag = textFieldIndex
            textFieldIndex += 1
            return textField
        }
        textFieldViews.first!.layout(.top, to: .bottom, of: titleLabel, offset: 20)
        textFieldViews.spread(.vertically, offset: 5)
        textFieldViews.layoutToSuperview(axis: .horizontally)
    }
    
    private func setupTextViews(with textViewsContent: [EKProperty.TextViewContent]) {
        
        if textViewsContent.count == 0 {
            return
        }
        
        var textViewIndex = 0
        textViewViews = textViewsContent.map { content -> EKTextView in
            let textView = EKTextView(with: content)
            scrollView.addSubview(textView)
            textView.tag = textViewIndex
            textViewIndex += 1
            return textView
        }
        textViewViews.first!.layout(.top, to: .bottom, of: textFieldViews.last!, offset: 10)
        textViewViews.spread(.vertically, offset: 5)
        textViewViews.layoutToSuperview(axis: .horizontally)
    }
    
    // Setup tap gesture
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureRecognized)
        )
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.layoutToSuperview(axis: .horizontally, offset: 20)
        scrollView.layoutToSuperview(axis: .vertically, offset: scrollViewVerticalOffset)
        scrollView.layoutToSuperview(.width, .height, offset: -scrollViewVerticalOffset * 2)
    }
    
    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top, .width)
        titleLabel.layoutToSuperview(axis: .horizontally)
        titleLabel.forceContentWrap(.vertically)
        titleLabel.content = titleContent
    }
    
    private func setupButton(with buttonContent: EKProperty.ButtonContent) {
        var buttonContent = buttonContent
        let action = buttonContent.action
        buttonContent.action = { [weak self] in
            self?.extractTextFieldsContent()
            self?.extractTextViewsContent()
            action?()
        }
        let buttonsBarContent = EKProperty.ButtonBarContent(
            with: buttonContent,
            separatorColor: .clear,
            expandAnimatedly: true
        )
        buttonBarView = EKButtonBarView(with: buttonsBarContent)
        buttonBarView.clipsToBounds = true
        scrollView.addSubview(buttonBarView)
        buttonBarView.expand()
        if textViewViews.count == 0 {
            buttonBarView.layout(.top, to: .bottom, of: textFieldViews.last!, offset: 20)
        } else {
            buttonBarView.layout(.top, to: .bottom, of: textViewViews.last!, offset: 20)
        }
        buttonBarView.layoutToSuperview(.centerX)
        buttonBarView.layoutToSuperview(.width, offset: -40)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.layer.cornerRadius = 5
    }
    
    private func extractTextFieldsContent() {
        for (content, textField) in zip(textFieldsContent, textFieldViews) {
            content.contentWrapper.text = textField.text
        }
    }
    
    private func extractTextViewsContent() {
        if textViewsContent.count == 0 {
            return
        }
        
        for (content, textView) in zip(textViewsContent, textViewViews) {
            content.contentWrapper.text = textView.text
        }
    }
    
    /** Makes a specific text field the first responder */
    public func becomeFirstResponder(with textFieldIndex: Int) {
        textFieldViews[textFieldIndex].makeFirstResponder()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        titleLabel.textColor = titleContent.style.color(for: traitCollection)
    }
    
    // MARK: User Intractions
    
    // Tap Gesture
    @objc func tapGestureRecognized() {
        endEditing(true)
    }
    
    // Textfield delegate
    public func addDelegate(_ delegate: UITextFieldDelegate?, forTextField accessibilityId: String) {
        let ekTextField = textFieldViews.first { (object) -> Bool in
            return object.textField.accessibilityIdentifier == accessibilityId
        }
        
        ekTextField?.set(delegate: delegate)
    }
    
    public func updateText(_ text: String?, forTextField accessibilityId: String) {
        let ekTextField = textFieldViews.first { (object) -> Bool in
            return object.textField.accessibilityIdentifier == accessibilityId
        }
        
        ekTextField?.textField.text = text
    }
}
