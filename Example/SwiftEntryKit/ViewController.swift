//
//  ViewController.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import SwiftEntryKit
import UIKit

class ViewController: UIViewController {

    private let dataSource = [
        Message(title: "Floating Top Entry", subtitle: "This is a floating top entry, this entry animates top-down, you can set margin and round corners for that entry"),
        Message(title: "Floating Bottom Entry", subtitle: "This is a floating bottom entry, this entry animates bottom-up, you can set margin and round corners for that entry"),
        Message(title: "Stretched Top Entry", subtitle: "This is a stretched top entry. This entry animates top-down, leaves no side margins. Also leaves  empty space outside the safe area"),
        Message(title: "Stretched Bottom Entry", subtitle: "This is a stretched bottom entry. This entry animates bottom-up, leaves no side margins. Also leaves empty space outside the safe area"),
        Message(title: "Note", subtitle: "This note comes from above and positioned in a window below the status bar level"),
        Message(title: "Processing Note", subtitle: "This note comes from above and positioned in a window below the status bar level. It indicates that something is being calculated at the background"),
        Message(title: "Status Bar Message", subtitle: "This note comes from above and positioned in a window below the status bar level. It indicates that something is being calculated at the background"),
        Message(title: "Custom Alert", subtitle: "This is a custom view that is positioned at the bottom")
        ]
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EntryKit Sample App"
        setupTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(EntryTableViewCell.self, forCellReuseIdentifier: String(describing: EntryTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fillSuperview()
    }

    private func showNote() {
        var attributes = EKAttributes.default
        attributes.location = .top
        attributes.shape = .stretched
        attributes.level = .belowStatusBar
        attributes.contentBackground = .color(color: .satCyan)
        attributes.rollOutAdditionalAnimation = nil

        let labelContent = EKProperty.LabelContent(text: "Pssst! I have something to tell you...", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: .white))
        let contentView = EKNoteMessageView(with: labelContent)
        
        show(view: contentView, attributes: attributes)
    }
    
    private func showProcessingNote() {
        var attributes = EKAttributes.default
        attributes.location = .top
        attributes.shape = .stretched
        attributes.level = .belowStatusBar
        attributes.contentInteraction = .absorbTouches
        attributes.visibleDuration = .infinity
        attributes.rollOutAdditionalAnimation = nil
        attributes.contentBackground = .color(color: .pinky)
        
        let labelContent = EKProperty.LabelContent(text: "Waiting for the goodies to arrive!", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: .white))
        
        let contentView = EKProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        show(view: contentView, attributes: attributes)
    }
    
    private func showStatusBarMessage() {
        var attributes = EKAttributes.default
        attributes.ignoreSafeArea = true
        attributes.location = .top
        attributes.shape = .stretched
        attributes.level = .aboveStatusBar
        attributes.contentInteraction = .absorbTouches
        attributes.contentBackground = .color(color: .greenGrass)
        attributes.rollOutAdditionalAnimation = nil
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        
        let contentView: UIView
        if statusBarHeight > 20 {
            let leading = EKProperty.LabelContent(text: "My 🧠", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 12), color: .white))
            let trailing = EKProperty.LabelContent(text: "Wonders!", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 12), color: .white))
            contentView = EKXStatusBarMessageView(leading: leading, trailing: trailing)
        } else {
            let labelContent = EKProperty.LabelContent(text: "My 🧠 is doing some thinking...", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 12), color: .white))
            let noteView = EKNoteMessageView(with: labelContent)
            noteView.verticalOffset = 0
            noteView.set(.height, of: statusBarHeight)
            contentView = noteView
        }
        
        show(view: contentView, attributes: attributes)
    }
    
    private func showNotificationMessage(attributes: EKAttributes = .topStretched, textColor: UIColor, imageName: String) {
        
        let title = EKProperty.LabelContent(text: "SHOPPING DISCOUNT", style: EKProperty.Label(font: UIFont.boldSystemFont(ofSize: 16), color: textColor))
        let description = EKProperty.LabelContent(text: "50% discount until midnight at Luzius Bakery", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: textColor))
        let time = EKProperty.LabelContent(text: "20:59", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 12), color: textColor))
        let image = UIImage(named: imageName)!
        
        let content = EKNotificationMessage(title: title, description: description, time: time, image: image)
        
        let contentView = EKNotificationMessageView(with: content)
        show(view: contentView, attributes: attributes)
    }
    
    private func showCustomNotificationMessage() {
        let title = EKProperty.LabelContent(text: "Awesome!", style: EKProperty.Label(font: UIFont.boldSystemFont(ofSize: 26), color: .darkText))
        let description = EKProperty.LabelContent(text: "You are using SwiftEntryKit, and this is a customized alert view that is floating at the bottom.", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 16), color: .darkSubText))
        let button = EKProperty.ButtonContent(label: EKProperty.LabelContent(text: "Got it!", style: EKProperty.Label(font: UIFont.boldSystemFont(ofSize: 16), color: .white)), backgroundColor: .amber)
        let image = UIImage(named: "ic_done_all_48pt")!
        let message = EKPopUpMessage(title: title, description: description, button: button, image: image) {
            EKWindowProvider.shared.dismiss()
        }
        
        var attributes = EKAttributes.bottomFloating
        attributes.visibleDuration = .infinity
        attributes.background = .color(color: .dimmedBackground)
        attributes.backgroundInteraction = .dismiss
        attributes.contentInteraction = .absorbTouches
        attributes.shape = .floating(info: EKAttributes.Frame(cornerRadius: 20))
        
        let contentView = EKPopUpMessageView(with: message)
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        show(view: contentView, attributes: attributes)
    }
    
    private func show(view: UIView, attributes: EKAttributes) {
        let containerView = EKContainerView()
        containerView.content = EKContainerView.Content(view: view, attributes: attributes)
        EKWindowProvider.shared.state = .message(view: containerView, attributes: attributes)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            var attributes = EKAttributes.topFloating
            attributes.contentBackground = .color(color: .satCyan)
            showNotificationMessage(attributes: attributes, textColor: .white, imageName: "ic_shopping_cart_light_32pt")
        case 1:
            var attributes = EKAttributes.bottomFloating
            attributes.contentBackground = .color(color: .redish)
            attributes.contentInteraction.defaultAction = .delayExit
            showNotificationMessage(attributes: attributes, textColor: .white, imageName: "ic_shopping_cart_light_32pt")
        case 2:
            showNotificationMessage(attributes: .topStretched, textColor: .black, imageName: "ic_shopping_cart_dark_32pt")
        case 3:
            showNotificationMessage(attributes: .bottomStretched, textColor: .black, imageName: "ic_shopping_cart_dark_32pt")
        case 4:
            showNote()
        case 5:
            showProcessingNote()
        case 6:
            showStatusBarMessage()
        case 7:
            showCustomNotificationMessage()
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EntryTableViewCell.self), for: indexPath) as! EntryTableViewCell
        cell.message = dataSource[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}
