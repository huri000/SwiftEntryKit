//
//  PresetTableViewCell.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import SwiftEntryKit
import QuickLayout
import UIKit

class PresetTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    private let thumbImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    var presetDescription: PresetDescription! {
        didSet {
            titleLabel.text = presetDescription.title
            descriptionLabel.text = presetDescription.description
            thumbImageView.image = UIImage(named: presetDescription.thumb)
        }
    }
    
    var displayMode: EKAttributes.DisplayMode = .inferred {
        didSet {
            setupInterfaceStyle()
        }
    }
    
    // MARK: - Setup
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupInterfaceStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(thumbImageView)
        thumbImageView.contentMode = .scaleAspectFit
        thumbImageView.layoutToSuperview(.left, .top, offset: 16)
        thumbImageView.set(.width, .height, of: 50)
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = MainFont.medium.with(size: 18)
        titleLabel.numberOfLines = 0
        titleLabel.layout(.left, to: .right, of: thumbImageView, offset: 16)
        titleLabel.layout(to: .top, of: thumbImageView)
        titleLabel.layoutToSuperview(.right, offset: -12)
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.font = MainFont.light.with(size: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 4)
        descriptionLabel.layout(to: .left, of: titleLabel)
        descriptionLabel.layout(to: .right, of: titleLabel)
        descriptionLabel.layoutToSuperview(.bottom, offset: -16)
    }
    
    private func setupInterfaceStyle() {
        contentView.backgroundColor = EKColor.standardBackground.color(
            for: traitCollection,
            mode: displayMode
        )
        titleLabel.textColor = EKColor.standardContent.color(
            for: traitCollection,
            mode: displayMode
        )
        descriptionLabel.textColor = EKColor.standardContent.with(alpha: 0.8).color(
            for: traitCollection,
            mode: displayMode
        )
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color: EKColor = highlighted ? .selectedBackground : .standardBackground
        contentView.backgroundColor = color.color(
            for: traitCollection,
            mode: displayMode
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}
