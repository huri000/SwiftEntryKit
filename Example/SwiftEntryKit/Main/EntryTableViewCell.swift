//
//  EntryTableViewCell.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import SwiftEntryKit
import QuickLayout
import UIKit

class EntryTableViewCell: UITableViewCell {

    // MARK: Props
    private let thumbImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    var attributesDescription: EntryAttributesDescription! {
        didSet {
            titleLabel.text = attributesDescription.title
            descriptionLabel.text = attributesDescription.description
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
        thumbImageView.image = UIImage(named: "ic_shopping_cart_dark_32pt")
        thumbImageView.layoutToSuperview(.left, .top, offset: 20)
        thumbImageView.set(.width, .height, of: 50)
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = Font.HelveticaNeue.medium.with(size: 18)
        titleLabel.numberOfLines = 0
        titleLabel.layout(.left, to: .right, of: thumbImageView, offset: 20)
        titleLabel.layout(to: .centerY, of: thumbImageView)
        titleLabel.layoutToSuperview(.right, offset: -20)
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.font = Font.HelveticaNeue.thin.with(size: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.layout(to: .left, of: thumbImageView)
        descriptionLabel.layout(to: .right, of: titleLabel)
        descriptionLabel.layout(.top, to: .bottom, of: thumbImageView, offset: 20)
        descriptionLabel.layoutToSuperview(.bottom, offset: -20)
    }
}
