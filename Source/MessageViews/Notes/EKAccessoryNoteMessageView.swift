//
//  EKAccessoryNoteMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/4/18.
//

import UIKit

public class EKAccessoryNoteMessageView: UIView {

    // MARK: Props
    private let contentView = UIView()
    private var noteMessageView: EKNoteMessageView!
    var accessoryView: UIView!

    func setup(with content: EKProperty.LabelContent) {
        clipsToBounds = true
        
        addSubview(contentView)
        contentView.layoutToSuperview(.centerX, .top, .bottom)
        contentView.layoutToSuperview(.left, relation: .greaterThanOrEqual, offset: 16)
        contentView.layoutToSuperview(.right, relation: .lessThanOrEqual, offset: -16)
        
        noteMessageView = EKNoteMessageView(with: content)
        noteMessageView.horizontalOffset = 8
        noteMessageView.verticalOffset = 7
        contentView.addSubview(noteMessageView)
        noteMessageView.layoutToSuperview(.top, .bottom, .trailing)
        
        contentView.addSubview(accessoryView)
        accessoryView.layoutToSuperview(.leading, .centerY)
        accessoryView.layout(.trailing, to: .leading, of: noteMessageView)
    }
}
