//
//  ViewController.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import SwiftEntryKit
import UIKit

class PresetsViewController: UIViewController {

    private var dataSource: [EntryAttributesDescription] = []
    private let tableView = UITableView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = EKColor.BlueGray.c700
        setupDataSource()
        setupTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    // MARK: Setup
    private func setupDataSource() {
        var attributes = EKAttributes.topFloat
        let gradient = EKAttributes.BackgroundStyle.Gradient(colors: [.amber, .pinky], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1))
        attributes.entryBackground = .gradient(gradient: gradient) // .color(color: .satCyan)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        var description = EntryAttributesDescription(with: attributes, title: "Top Floating Banner")
        dataSource.append(description)
        
        description = EntryAttributesDescription(with: .topToast, title: "Top Toast")
        dataSource.append(description)
        
        attributes = EKAttributes.bottomFloat
        attributes.entryBackground = .color(color: .redish)
        attributes.entryInteraction = .delayExit(by: 3)
        description = EntryAttributesDescription(with: attributes, title: "Bottom Floating Banner")
        dataSource.append(description)

        description = EntryAttributesDescription(with: .bottomToast, title: "Bottom Toast")
        dataSource.append(description)
        
        attributes = EKAttributes.topToast
        attributes.windowLevel = .belowStatusBar
        attributes.entryBackground = .color(color: .satCyan)
        attributes.options.popBehavior = .animated(animation: .translation)
        description = EntryAttributesDescription(with: attributes, title: "Top Single Line Note")
        dataSource.append(description)
        
        attributes = EKAttributes.topToast
        attributes.windowLevel = .belowStatusBar
        attributes.entryInteraction = .absorbTouches
        attributes.displayDuration = .infinity
        attributes.options.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .pinky)
        description = EntryAttributesDescription(with: attributes, title: "Top Single Line Processing Note (Infinate Duration)")
        dataSource.append(description)
        
        attributes = EKAttributes.statusBar
        attributes.entryBackground = .color(color: .greenGrass)
        attributes.options.popBehavior = .animated(animation: .translation)
        description = EntryAttributesDescription(with: attributes, title: "Status Bar Temporary Cover")
        dataSource.append(description)

        attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .dimmedBackground)
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.roundCorners = .all(radius: 25)
        attributes.positionConstraints = EKAttributes.PositionConstraints(verticalOffset: 10, width: .offset(value: 20))
        description = EntryAttributesDescription(with: attributes, title: "Bottom Floating Alert View")
        dataSource.append(description)
        
        attributes = EKAttributes.bottomFloat
        attributes.displayDuration = 4
        attributes.screenBackground = .clear
        attributes.screenInteraction = .forward
        attributes.entryInteraction = .absorbTouches
        attributes.roundCorners = .none
        attributes.positionConstraints = EKAttributes.PositionConstraints(verticalOffset: 10, width: .offset(value: 20))
        description = EntryAttributesDescription(with: attributes, title: "Bottom Floating Custom View")
        dataSource.append(description)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(EntryTableViewCell.self, forCellReuseIdentifier: String(describing: EntryTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fillSuperview()
    }

    // MARK: Entry Samples
    
    private func showNote(attributes: EKAttributes) {
        let labelContent = EKProperty.LabelContent(text: "Pssst! I have something to tell you...", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: .white))
        let contentView = EKNoteMessageView(with: labelContent)
        
        show(view: contentView, attributes: attributes)
    }
    
    private func showProcessingNote(attributes: EKAttributes) {
        let labelContent = EKProperty.LabelContent(text: "Waiting for the goodies to arrive!", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: .white))
        
        let contentView = EKProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        show(view: contentView, attributes: attributes)
    }
    
    private func showStatusBarMessage(attributes: EKAttributes) {
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
    
    private func showNotificationMessage(attributes: EKAttributes, textColor: UIColor, imageName: String) {
        let title = EKProperty.LabelContent(text: "SHOPPING DISCOUNT", style: EKProperty.Label(font: UIFont.boldSystemFont(ofSize: 16), color: textColor))
        let description = EKProperty.LabelContent(text: "50% discount until midnight at Luzius Bakery", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: textColor))
        let time = EKProperty.LabelContent(text: "20:59", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 12), color: textColor))
        let image = UIImage(named: imageName)!
        
        let content = EKNotificationMessage(title: title, description: description, time: time, image: image)
        
        let contentView = EKNotificationMessageView(with: content)
        show(view: contentView, attributes: attributes)
    }
    
    private func showAlertMessage(attributes: EKAttributes) {
        let title = EKProperty.LabelContent(text: "Awesome!", style: EKProperty.Label(font: UIFont.boldSystemFont(ofSize: 26), color: .darkText))
        let description = EKProperty.LabelContent(text: "You are using SwiftEntryKit, and this is a customized alert view that is floating at the bottom.", style: EKProperty.Label(font: UIFont.systemFont(ofSize: 16), color: .darkSubText))
        let button = EKProperty.ButtonContent(label: EKProperty.LabelContent(text: "Got it!", style: EKProperty.Label(font: UIFont.boldSystemFont(ofSize: 16), color: .white)), backgroundColor: .amber)
        let image = UIImage(named: "ic_done_all_48pt")!
        let message = EKPopUpMessage(title: title, description: description, button: button, image: image) {
            EKWindowProvider.shared.dismiss()
        }
        
        let contentView = EKPopUpMessageView(with: message)
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        show(view: contentView, attributes: attributes)
    }
    
    private func showCustomNibView(attributes: EKAttributes) {
        let customNibView = NibExampleView()
        show(view: customNibView, attributes: attributes)
    }
    
    private func show(view: UIView, attributes: EKAttributes) {
        let containerView = EKContainerView()
        containerView.content = EKContainerView.Content(view: view, attributes: attributes)
        EKWindowProvider.shared.state = .message(view: containerView, attributes: attributes)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension PresetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let attributes = dataSource[indexPath.row].attributes
        switch indexPath.row {
        case 0:
            showNotificationMessage(attributes: attributes, textColor: .white, imageName: "ic_shopping_cart_light_32pt")
        case 1:
            showNotificationMessage(attributes: attributes, textColor: .black, imageName: "ic_shopping_cart_dark_32pt")
        case 2:
            showNotificationMessage(attributes: attributes, textColor: .white, imageName: "ic_shopping_cart_light_32pt")
        case 3:
            showNotificationMessage(attributes: attributes, textColor: .black, imageName: "ic_shopping_cart_dark_32pt")
        case 4:
            showNote(attributes: attributes)
        case 5:
            showProcessingNote(attributes: attributes)
        case 6:
            showStatusBarMessage(attributes: attributes)
        case 7:
            showAlertMessage(attributes: attributes)
        case 8:
            showCustomNibView(attributes: attributes)
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EntryTableViewCell.self), for: indexPath) as! EntryTableViewCell
        cell.attributesDescription = dataSource[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}
