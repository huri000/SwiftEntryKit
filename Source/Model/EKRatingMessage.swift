//
//  EKRatingMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 6/1/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation

public struct EKRatingMessage {
    
    // NOTE: Intentionally a reference type
    class SelectedIndex {
        var selectedIndex: Int!
    }
    
    /** Selection */
    public typealias Selection = (Int) -> Void

    /** Initial title */
    public var initialTitle: EKProperty.LabelContent
    
    /** Initial description */
    public var initialDescription: EKProperty.LabelContent
    
    /** Rating items */
    public var ratingItems: [EKProperty.EKRatingItemContent]
    
    /** Button bar content appears after selection */
    public var buttonBarContent: EKProperty.ButtonBarContent
    
    /** Selection event - Each time the user interacts a rating star */
    public var selection: Selection!

    let selectedIndexRef = SelectedIndex()
    
    /** Selected index (if there is one) */
    public var selectedIndex: Int? {
        get {
            return selectedIndexRef.selectedIndex
        }
        set {
            selectedIndexRef.selectedIndex = newValue
        }
    }
    
    /** Initializer */
    public init(initialTitle: EKProperty.LabelContent,
                initialDescription: EKProperty.LabelContent,
                ratingItems: [EKProperty.EKRatingItemContent],
                buttonBarContent: EKProperty.ButtonBarContent,
                selection: Selection? = nil) {
        self.initialTitle = initialTitle
        self.initialDescription = initialDescription
        self.ratingItems = ratingItems
        self.buttonBarContent = buttonBarContent
        self.selection = selection
    }
}
