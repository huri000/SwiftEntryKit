//
//  PresetDescription.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import SwiftEntryKit

// Description of a single preset to be presented
struct PresetDescription {
    let title: String
    let description: String
    let attributes: EKAttributes
    
    init(with attributes: EKAttributes, title: String, description: String = "") {
        self.title = title
        self.description = description
        self.attributes = attributes
    }
}
