//
//  EKImageNoteMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/4/18.
//

import Foundation

public class EKImageNoteMessageView: EKAccessoryNoteMessageView {
    
    // MARK: Setup
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(with content: EKProperty.LabelContent, imageContent: EKProperty.ImageContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(with: content, imageContent: imageContent)
    }
    
    private func setup(with content: EKProperty.LabelContent, imageContent: EKProperty.ImageContent) {
        let imageView = UIImageView()
        imageView.imageContent = imageContent
        accessoryView = imageView
        super.setup(with: content)
    }
}
