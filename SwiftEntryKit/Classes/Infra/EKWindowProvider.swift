//
//  EKWindowProvider.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public class EKWindowProvider {
    
    public enum State {
        case message(view: EKContainerView, attributes: EKAttributes)
        case main
        
        var isMain: Bool {
            switch self {
            case .main:
                return true
            default:
                return false
            }
        }
    }

    public var state: State = .main {
        didSet {
            switch state {
            case .main:
                clean()
            case .message(view: let view, attributes: let attributes):
                if oldValue.isMain {
                    previousStatusBarStyle = UIApplication.shared.statusBarStyle
                }
                if let newStatusBarStyle = attributes.statusBarStyle {
                    UIApplication.shared.statusBarStyle = newStatusBarStyle
                }
                setup(with: view, attributes: attributes)
            }
        }
    }
    
    public func dismiss() {
        guard let rootVC = rootVC else {
            return
        }
        rootVC.rollOutLastEntry()
    }
    
    private var previousStatusBarStyle: UIStatusBarStyle!
        
    var rootVC: EKRootViewController? {
        return entryWindow?.rootViewController as? EKRootViewController
    }
    
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return EKWindowProvider.shared.entryWindow?.rootViewController?.view?.safeAreaInsets ?? UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
    
    public static let shared = EKWindowProvider()
    private init() {}
    
    var entryWindow: EKWindow!
    
    // MARK: Setup and Teardown methods
    private func setup(with messageView: UIView, attributes: EKAttributes) {
        let entryVC: EKRootViewController
        if entryWindow == nil {
            entryWindow = EKWindow()
            entryWindow.frame = UIScreen.main.bounds
            entryWindow.backgroundColor = .clear
            entryVC = EKRootViewController()
            entryWindow.rootViewController = entryVC
            entryWindow.makeKeyAndVisible()
        } else {
            entryVC = rootVC!
        }
        entryWindow.windowLevel = attributes.windowLevel.value
        entryVC.configure(entryView: messageView, attributes: attributes)
    }
    
    private func clean() {
        UIApplication.shared.statusBarStyle = previousStatusBarStyle
        entryWindow = nil
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}
