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
    
    var attributes: EKAttributes {
        return content.attributes
    }

    public init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var contentView: UIView! {
        didSet {
            oldValue?.removeFromSuperview()
            addSubview(contentView)
            contentView.clipsToBounds = true
            contentView.layoutToSuperview(axis: .vertically)
            contentView.layoutToSuperview(axis: .horizontally)
            
            contentView.layer.cornerRadius = attributes.frame.cornerRadius

            applyBackgroundToContentView()
        }
    }
    
    private func applyBackgroundToContentView() {
        
        let attributes = content.attributes
        
        let backgroundView = EKBackgroundView()
        backgroundView.background = attributes.entryBackground
        
        switch attributes.options.safeAreaBehavior {
        case .empty(fillSafeArea: let fillSafeArea) where fillSafeArea:
            insertSubview(backgroundView, at: 0)
            backgroundView.layoutToSuperview(axis: .horizontally)
            
            var topInset: CGFloat = 0
            var bottomInset: CGFloat = 0
            if attributes.position.isTop {
                topInset = -EKWindowProvider.safeAreaInsets.top
            } else {
                bottomInset = EKWindowProvider.safeAreaInsets.bottom
            }
            
            backgroundView.layoutToSuperview(.top, offset: topInset)
            backgroundView.layoutToSuperview(.bottom, offset: bottomInset)
        default:
            contentView.insertSubview(backgroundView, at: 0)
            backgroundView.fillSuperview()
        }
    }
}
