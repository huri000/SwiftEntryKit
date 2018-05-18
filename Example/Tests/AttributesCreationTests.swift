//
//  AttributesCreation.swift
//  SwiftEntryKitDemo
//
//  Created by Daniel Huri on 5/18/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftEntryKit

class AttributesCreation: QuickSpec {

    override func spec() {
        attributesCreation()
    }
    
    private func attributesCreation() {
        
        describe("attributes creation") {
            
            describe("its display duration initialization") {
                
                var attributes: EKAttributes!
                var duration: EKAttributes.DisplayDuration!

                beforeEach {
                    attributes = EKAttributes()
                }
                
                it("displays for infinate time") {
                    duration = .infinity
                    attributes.displayDuration = duration
                    
                    expect(attributes.displayDuration).to(equal(duration))
                    expect(attributes.validateDisplayDuration).to(beTrue())
                    expect(attributes.isValid).to(beTrue())
                }
                
                it("displays for a constant time") {
                    duration = 1
                    attributes.displayDuration = duration
                    
                    expect(attributes.displayDuration).to(equal(duration))
                    expect(attributes.validateDisplayDuration).to(beTrue())
                    expect(attributes.isValid).to(beTrue())
                }
            }

            describe("its window level initialization") {
                
                var attributes: EKAttributes!
                var windowLevel: EKAttributes.WindowLevel!
                
                beforeEach {
                    attributes = EKAttributes()
                }
                
                it("is has a normal level") {
                    windowLevel = .normal
                    attributes.windowLevel = windowLevel
                    
                    expect(attributes.windowLevel.value).to(equal(UIWindowLevelNormal))
                    expect(attributes.validateWindowLevel).to(beTrue())
                    expect(attributes.isValid).to(beTrue())
                }
                
                it("is has a status bar level") {
                    windowLevel = .statusBar
                    attributes.windowLevel = windowLevel
                    
                    expect(attributes.windowLevel.value).to(equal(UIWindowLevelStatusBar))
                    expect(attributes.validateWindowLevel).to(beTrue())
                    expect(attributes.isValid).to(beTrue())
                }
                
                it("is has an alerts level") {
                    windowLevel = .alerts
                    attributes.windowLevel = windowLevel
                    
                    expect(attributes.windowLevel.value).to(equal(UIWindowLevelAlert))
                    expect(attributes.validateWindowLevel).to(beTrue())
                    expect(attributes.isValid).to(beTrue())
                }
                
                it("is has a custom level") {
                    let level: UIWindowLevel = 1
                    windowLevel = .custom(level: level)
                    attributes.windowLevel = windowLevel
                    
                    expect(attributes.windowLevel.value).to(equal(level))
                    expect(attributes.validateWindowLevel).to(beTrue())
                    expect(attributes.isValid).to(beTrue())
                }
                
                it("is cannot have negative level") {
                    let level: UIWindowLevel = -1
                    windowLevel = .custom(level: level)
                    attributes.windowLevel = windowLevel
                    
                    expect(attributes.windowLevel.value).to(equal(level))
                    expect(attributes.validateWindowLevel).to(beFalse())
                    expect(attributes.isValid).to(beFalse())
                }
            }

        }
    }
}
