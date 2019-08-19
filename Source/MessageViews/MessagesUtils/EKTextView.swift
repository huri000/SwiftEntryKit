//
//  EKTextView.swift
//  SwiftEntryKit
//
//  Created by Ninoy on 8/19/19.
//

import UIKit

class EKTextView: UIView {
    
    // MARK: - Properties
    
    static let totalHeight: CGFloat = 200
    
    private let content: EKProperty.TextViewContent
    
    private let textView = UITextView()
    private let separatorView = UIView()
    
    public var text: String {
        set {
            textView.text = newValue
        }
        get {
            return textView.text ?? ""
        }
    }
    
    // MARK: - Setup
    
    public init(with content: EKProperty.TextViewContent) {
        self.content = content
        super.init(frame: UIScreen.main.bounds)
        setupTextView()
        setupSeparatorView()
        textView.accessibilityIdentifier = content.accessibilityIdentifier
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextView() {
        addSubview(textView)
        textView.textViewContent = content
        textView.set(.height, of: EKTextView.totalHeight)
        textView.layoutToSuperview(.top, .trailing, .leading)
    }
    
    private func setupSeparatorView() {
        addSubview(separatorView)
        separatorView.layout(.top, to: .bottom, of: textView)
        separatorView.set(.height, of: 1)
        separatorView.layoutToSuperview(.bottom)
        separatorView.layoutToSuperview(axis: .horizontally, offset: 10)
        separatorView.backgroundColor = content.bottomBorderColor.color(
            for: traitCollection,
            mode: content.displayMode
        )
    }
    
    public func makeFirstResponder() {
        textView.becomeFirstResponder()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        separatorView.backgroundColor = content.bottomBorderColor(for: traitCollection)
        textView.textColor = content.textStyle.color(for: traitCollection)
        textView.placeholder = content.placeholder
    }
    
}
