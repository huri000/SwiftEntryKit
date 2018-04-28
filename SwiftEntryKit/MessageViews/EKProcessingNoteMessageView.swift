//
//  EKProcessingNoteMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public class EKProcessingNoteMessageView: UIView {
    
    // MARK: Props
    private let activityIndicatorView = UIActivityIndicatorView()
    private var noteMessageView: EKNoteMessageView!
    
    public var isProcessing: Bool = true {
        didSet {
            if isProcessing {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }
    
    // MARK: Setup
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(with content: EKProperty.LabelContent, activityIndicator: UIActivityIndicatorViewStyle) {
        super.init(frame: UIScreen.main.bounds)
        setup(with: content, activityIndicator: activityIndicator)
    }
    
    private func setup(with content: EKProperty.LabelContent, activityIndicator: UIActivityIndicatorViewStyle) {
        clipsToBounds = true
        noteMessageView = EKNoteMessageView(with: content)
        noteMessageView.horizontalOffset = 5
        noteMessageView.verticalOffset = 7
        addSubview(noteMessageView)
        noteMessageView.centerInSuperview()
        noteMessageView.layoutToSuperview(.width, ratio: 0.7)
        noteMessageView.layoutToSuperview(.height)
        
        activityIndicatorView.activityIndicatorViewStyle = activityIndicator
        addSubview(activityIndicatorView)
        activityIndicatorView.layoutToSuperview(.centerY)
        activityIndicatorView.layout(.right, to: .left, of: noteMessageView)
        isProcessing = true
    }
}
