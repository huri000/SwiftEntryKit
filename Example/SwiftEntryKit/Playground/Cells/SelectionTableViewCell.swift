//
//  SelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/23/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

class SelectionBaseCell: UITableViewCell {
    func configure(attributesWrapper: EntryAttributeWrapper) {}
}

class SelectionTableViewCell: SelectionBaseCell {

    enum Focus: String {
        case entry
        case screen
    }
    
    enum Setting {
        case position
        case windowLevel
    }
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    let segmentedControl = UISegmentedControl()
    
    var attributesWrapper: EntryAttributeWrapper!
    
    var attributes: EKAttributes {
        return attributesWrapper.attributes
    }
    
    var titleValue: String {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text ?? ""
        }
    }
    
    var descriptionValue: String {
        set {
            descriptionLabel.text = newValue
        }
        get {
            return descriptionLabel.text ?? ""
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitleLabel()
        setupDescriptionLabel()
        setupSegmentedControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.textColor = EKColor.BlueGray.c900
        titleLabel.font = MainFont.bold.with(size: 18)
        titleLabel.layoutToSuperview(.top, offset: 20)
        titleLabel.layoutToSuperview(axis: .horizontally, offset: 20)
        titleLabel.forceContentWrap(.vertically)
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = EKColor.BlueGray.c800
        descriptionLabel.font = MainFont.light.with(size: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 10)
        descriptionLabel.layoutToSuperview(axis: .horizontally, offset: 20)
        descriptionLabel.forceContentWrap(.vertically)
    }
    
    private func setupSegmentedControl() {
        contentView.addSubview(segmentedControl)
        segmentedControl.tintColor = UIColor(rgb: 0x37474f)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: MainFont.light.with(size: 15)], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: MainFont.medium.with(size: 15)], for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.layout(.top, to: .bottom, of: descriptionLabel, offset: 10)
        segmentedControl.layoutToSuperview(axis: .horizontally, offset: 20)
        segmentedControl.layoutToSuperview(.bottom, offset: -20)
    }
    
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        segmentedControl.removeAllSegments()
        self.attributesWrapper = attributesWrapper
    }
    
    func insertSegments(by array: [String]) {
        for (index, info) in array.enumerated() {
            segmentedControl.insertSegment(withTitle: info, at: index, animated: false)
        }
    }
    
    @objc func segmentChanged() {}
}
