//
//  AttributesCreation.swift
//  SwiftEntryKitDemo
//
//  Created by Daniel Huri on 5/18/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import XCTest
@testable import SwiftEntryKit

class AttributesCreationTest: XCTestSuite {

    func testDisplayPriorityInitMax() {
        var attributes = EKAttributes()
        attributes.precedence.priority = .max
        XCTAssertEqual(attributes.precedence.priority, .max)
        XCTAssertEqual(attributes.precedence.priority.rawValue, EKAttributes.Precedence.Priority.maxRawValue)
    }
    
    func testDisplayPriorityInitHigh() {
        var attributes = EKAttributes()
        attributes.precedence.priority = .high
        XCTAssertEqual(attributes.precedence.priority, .high)
        XCTAssertEqual(attributes.precedence.priority.rawValue, EKAttributes.Precedence.Priority.maxRawValue)
    }
    
    func testDisplayPriorityInitCustom() {
        
        var attributes = EKAttributes()

        let custom1 = EKAttributes.Precedence.override(priority: .init(999), dropEnqueuedEntries: true)
        attributes.precedence.priority = custom1.priority
        XCTAssertEqual(attributes.precedence.priority, custom1.priority)
        XCTAssertEqual(attributes.precedence.priority.rawValue, 999)
        
        let custom2 = EKAttributes.Precedence.override(priority: .init(1), dropEnqueuedEntries: true)
        attributes.precedence.priority = custom2.priority
        XCTAssertEqual(attributes.precedence.priority, custom2.priority)
        XCTAssertEqual(attributes.precedence.priority.rawValue, 1)
        
        XCTAssertLessThan(custom2.priority, custom1.priority)
    }
    
    func testPositionTop() {
        var attributes = EKAttributes()
        attributes.position = .top
        XCTAssertEqual(attributes.position, .top)
        XCTAssertTrue(attributes.position.isTop)
    }
    
    func testPositionCenter() {
        var attributes = EKAttributes()
        attributes.position = .center
        XCTAssertEqual(attributes.position, .center)
        XCTAssertTrue(attributes.position.isCenter)
    }
    
    func testPositionBottom() {
        var attributes = EKAttributes()
        attributes.position = .bottom
        XCTAssertEqual(attributes.position, .bottom)
        XCTAssertTrue(attributes.position.isBottom)
    }
            
    func testDisplayDurationInfinite() {
        var attributes = EKAttributes()
        attributes.displayDuration = .infinity
        XCTAssertTrue(attributes.validateDisplayDuration)
        XCTAssertTrue(attributes.isValid)
    }
    
    func testDisplayDurationConstant() {
        var attributes = EKAttributes()
        attributes.displayDuration = 1
        XCTAssertTrue(attributes.validateDisplayDuration)
        XCTAssertTrue(attributes.isValid)
    }

    
    func testWindowLevelNormal() {
        var attributes = EKAttributes()
        attributes.windowLevel = .normal
        XCTAssertEqual(attributes.windowLevel.value, .normal)
        XCTAssertTrue(attributes.validateWindowLevel)
        XCTAssertTrue(attributes.isValid)
    }
    
    func testWindowLevelStatus() {
        var attributes = EKAttributes()
        attributes.windowLevel = .statusBar
        XCTAssertEqual(attributes.windowLevel.value, .statusBar)
        XCTAssertTrue(attributes.validateWindowLevel)
        XCTAssertTrue(attributes.isValid)
    }
    
    func testWindowLevelAlert() {
        var attributes = EKAttributes()
        attributes.windowLevel = .alerts
        XCTAssertEqual(attributes.windowLevel.value, .alert)
        XCTAssertTrue(attributes.validateWindowLevel)
        XCTAssertTrue(attributes.isValid)
    }
    
    func testWindowLevelCustom() {
        var attributes = EKAttributes()
        let level = UIWindow.Level(rawValue: 1)
        attributes.windowLevel = .custom(level: level)
        
        XCTAssertEqual(attributes.windowLevel.value, level)
        XCTAssertTrue(attributes.validateWindowLevel)
        XCTAssertTrue(attributes.isValid)
    }
    
    func testWindowLevelNegative() {
        var attributes = EKAttributes()
        let level = UIWindow.Level(rawValue: -1)
        attributes.windowLevel = .custom(level: level)
        
        XCTAssertEqual(attributes.windowLevel.value, level)
        XCTAssertFalse(attributes.validateWindowLevel)
        XCTAssertFalse(attributes.isValid)
    }

}
