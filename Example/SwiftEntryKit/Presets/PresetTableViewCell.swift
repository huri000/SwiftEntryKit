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

    // MARK: Props
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
    
    // MARK: Setup
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
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
        titleLabel.textColor = .black
        titleLabel.font = MainFont.medium.with(size: 18)
        titleLabel.numberOfLines = 0
        titleLabel.layout(.left, to: .right, of: thumbImageView, offset: 16)
        titleLabel.layout(to: .top, of: thumbImageView)
        titleLabel.layoutToSuperview(.right, offset: -12)
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.textColor = EKColor.Gray.mid
        descriptionLabel.font = MainFont.light.with(size: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 4)
        descriptionLabel.layout(to: .left, of: titleLabel)
        descriptionLabel.layout(to: .right, of: titleLabel)
        descriptionLabel.layoutToSuperview(.bottom, offset: -16)
    }
}
