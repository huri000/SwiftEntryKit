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
        case transform(to: UIView)
        case entry(view: UIView, attributes: EKAttributes)
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
    
    // Safe area insets
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return EKWindowProvider.shared.entryWindow?.rootViewController?.view?.safeAreaInsets ?? UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets ?? .zero
        } else {
            let statusBarMaxY = UIApplication.shared.statusBarFrame.maxY
            return UIEdgeInsets(top: statusBarMaxY, left: 0, bottom: 10, right: 0)
        }
    }
    
    // Shared
    static let shared = EKWindowProvider()

    // State
    public internal(set) var state: State = .main {
        didSet {
            switch state {
            case .main:
                clean()
            case .entry(view: let view, attributes: let attributes):
                setup(with: view, attributes: attributes)
            case .transform(to: let view):
                transform(to: view)
            }
        }
    }
    
    // Entry window
    var entryWindow: EKWindow!
    
    // Root view controller
    var rootVC: EKRootViewController? {
        return entryWindow?.rootViewController as? EKRootViewController
    }
    
    private weak var entryView: EKEntryView!

    private init() {}
    
    // MARK: Setup and Teardown methods
    
    // Setup new entry
    private func setup(with view: UIView, attributes: EKAttributes) {
        
        let entryVC = setupWindowAndRootVC()
        
        guard entryVC.canDisplay(attributes: attributes) else {
            return
        }
    
        entryWindow.windowLevel = attributes.windowLevel.value

        entryVC.setStatusBarStyle(for: attributes)
        
        let entryView = EKEntryView()
        entryView.setup(newEntry: .init(view: view, attributes: attributes))
        entryVC.configure(newEntryView: entryView, attributes: attributes)
        self.entryView = entryView
    }
    
    // Transform current entry
    private func transform(to view: UIView) {
        entryView?.transform(to: view)
    }
    
    // Setup window and root view controller
    private func setupWindowAndRootVC() -> EKRootViewController {
        let entryVC: EKRootViewController
        if entryWindow == nil {
            entryVC = EKRootViewController()
            entryWindow = EKWindow(with: entryVC)
        } else {
            entryVC = rootVC!
        }
        return entryVC
    }
    
    private func clean() {
        entryWindow = nil
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    func dismiss() {
        guard let rootVC = rootVC else {
            return
        }
        rootVC.animateOutLastEntry()
    }
    
    func layoutIfNeeded() {
        entryWindow?.layoutIfNeeded()
    }
}
