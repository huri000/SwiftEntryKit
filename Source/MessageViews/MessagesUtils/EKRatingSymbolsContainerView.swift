//
//  EKRatingSymbolsContainerView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 6/1/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation

public class EKRatingSymbolsContainerView: UIView {
    
    private var message: EKRatingMessage!
    private var symbolsArray: [EKRatingSymbolView] = []
    
    public func setup(with message: EKRatingMessage, externalSelection: @escaping EKRatingMessage.Selection) {
        self.message = message
        let internalSelection = { [unowned self] (index: Int) in
            self.select(index: index)
            externalSelection(index)
        }
        
        for (index, item) in message.ratingItems.enumerated() {
            let itemView = EKRatingSymbolView(unselectedImage: item.unselectedImage, selectedImage: item.selectedImage, selection: internalSelection)
            itemView.tag = index
            addSubview(itemView)
            itemView.set(.width, .height, of: 50)
            symbolsArray.append(itemView)
        }
        symbolsArray.layoutToSuperview(axis: .vertically, priority: .must)
        symbolsArray.spread(.horizontally, stretchEdgesToSuperview: true)
        
        select()
    }
    
    private func select(index: Int? = nil) {
        var delay: TimeInterval = 0
        for (i, view) in symbolsArray.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if let index = index, i <= index {
                    view.isSelected = true
                    view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                } else if view.isSelected || index == nil {
                    view.isSelected = false
                    view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                    view.transform = .identity
                }, completion: nil)
            }
            delay += 0.05
        }
    }
}
