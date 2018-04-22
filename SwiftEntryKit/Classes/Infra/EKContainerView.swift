//
//  EKContainerView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/15/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout

public class EKContainerView: UIView {
        
    public struct Content {
        public var view: UIView
        public var attributes: EKAttributes
        
        public init(view: UIView, attributes: EKAttributes) {
            self.view = view
            self.attributes = attributes
        }
    }
    
    public var content: Content! {
        didSet {
            contentView = content.view
        }
    }

    private var contentView: UIView! {
        didSet {
            oldValue?.removeFromSuperview()
            addSubview(contentView)
            contentView.clipsToBounds = true
            contentView.layoutToSuperview(axis: .vertically)
            contentView.layoutToSuperview(axis: .horizontally)
            
            switch content.attributes.shape {
            case .floating(info: let info):
                contentView.layer.cornerRadius = info.cornerRadius
            default:
                break
            }
            
            applyBackgroundToContentView()
        }
    }
    
    private func applyBackgroundToContentView() {
        
        let attributes = content.attributes
        
        let backgroundView = EKBackgroundView()
        backgroundView.background = attributes.contentBackground
        
        switch attributes.shape {
        case .stretched:
            insertSubview(backgroundView, at: 0)
            backgroundView.layoutToSuperview(axis: .horizontally)
            var topInset: CGFloat = 0
            var bottomInset: CGFloat = 0
            if !attributes.options.ignoreSafeArea {
                if attributes.location.isTop {
                    topInset = -EKWindowProvider.safeAreaInsets.top
                } else {
                    bottomInset = EKWindowProvider.safeAreaInsets.bottom
                }
            }
            backgroundView.layoutToSuperview(.top, offset: topInset)
            backgroundView.layoutToSuperview(.bottom, offset: bottomInset)
        case .floating(info: _):
            contentView.insertSubview(backgroundView, at: 0)
            backgroundView.fillSuperview()
        }
    }
}
