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

    // MARK: Props
    private let dataSource = PresetsDataSource()
    private let tableView = UITableView()
    
    // MARK: Lifecycle & Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = EKColor.BlueGray.c700
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(EntryTableViewCell.self, forCellReuseIdentifier: EntryTableViewCell.className)
        tableView.register(SelectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SelectionHeaderView.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fillSuperview()
    }

    // MARK: Entry Samples
    
    // Bumps a standard note
    private func showNote(attributes: EKAttributes) {
        let text = "Pssst! I have something to tell you..."
        let style = EKProperty.Label(font: Font.HelveticaNeue.light.with(size: 14), color: .white)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        let contentView = EKNoteMessageView(with: labelContent)

        EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
    }
    
    // Bumps an infinate processing note
    private func showProcessingNote(attributes: EKAttributes) {
        let text = "Waiting for the goodies to arrive!"
        let style = EKProperty.Label(font: Font.HelveticaNeue.light.with(size: 14), color: .white)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
    }
    
    // Bumps a status bar replacement entry
    private func showStatusBarMessage(attributes: EKAttributes) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        
        let contentView: UIView
        let font = Font.HelveticaNeue.light.with(size: 12)
        let labelStyle = EKProperty.Label(font: font, color: .white)
        if statusBarHeight > 20 {
            let leading = EKProperty.LabelContent(text: "My 🧠", style: labelStyle)
            let trailing = EKProperty.LabelContent(text: "Wonders!", style: labelStyle)
            contentView = EKXStatusBarMessageView(leading: leading, trailing: trailing)
        } else {
            let labelContent = EKProperty.LabelContent(text: "My 🧠 is doing some thinking...", style: labelStyle)
            let noteView = EKNoteMessageView(with: labelContent)
            noteView.verticalOffset = 0
            noteView.set(.height, of: statusBarHeight)
            contentView = noteView
        }
        
        EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
    }
    
    // Bumps a notification structured entry
    private func showNotificationMessage(attributes: EKAttributes, textColor: UIColor, imageName: String) {
        let title = EKProperty.LabelContent(text: "SHOPPING DISCOUNT", style: EKProperty.Label(font: Font.HelveticaNeue.medium.with(size: 16), color: textColor))
        let description = EKProperty.LabelContent(text: "50% discount until midnight at Luzius Bakery", style: EKProperty.Label(font: Font.HelveticaNeue.light.with(size: 14), color: textColor))
        let time = EKProperty.LabelContent(text: "20:59", style: EKProperty.Label(font: Font.HelveticaNeue.light.with(size: 12), color: textColor))
        let image = UIImage(named: imageName)!
        
        let content = EKNotificationMessage(title: title, description: description, time: time, image: image, roundImage: false)
        
        let contentView = EKNotificationMessageView(with: content)
        EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
    }
    
    // Bumps a chat message structured entry
    private func showChatNotificationMessage(attributes: EKAttributes) {
        let title = EKProperty.LabelContent(text: "Madi", style: EKProperty.Label(font: Font.HelveticaNeue.medium.with(size: 14), color: .white))
        let description = EKProperty.LabelContent(text: "Hey! I'll come by at your office for lunch... 🍲", style: EKProperty.Label(font: Font.HelveticaNeue.light.with(size: 12), color: .white))
        let time = EKProperty.LabelContent(text: "09:00", style: EKProperty.Label(font: Font.HelveticaNeue.light.with(size: 10), color: .white))
        let image = UIImage(named: "profile")!
        
        let content = EKNotificationMessage(title: title, description: description, time: time, image: image, roundImage: true)
        let contentView = EKNotificationMessageView(with: content)
        EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
    }
    
    // Bumps a custom alert entry
    private func showAlertMessage(attributes: EKAttributes) {
        let title = EKProperty.LabelContent(text: "Awesome!", style: EKProperty.Label(font: Font.HelveticaNeue.bold.with(size: 26), color: .darkText))
        let description = EKProperty.LabelContent(text: "You are using SwiftEntryKit, and this is a customized alert view that is floating at the bottom.", style: EKProperty.Label(font: Font.HelveticaNeue.medium.with(size: 16), color: .darkSubText))
        let button = EKProperty.ButtonContent(label: EKProperty.LabelContent(text: "Got it!", style: EKProperty.Label(font: Font.HelveticaNeue.bold.with(size: 16), color: .white)), backgroundColor: .amber)
        let image = UIImage(named: "ic_done_all_48pt")!
        let message = EKPopUpMessage(title: title, description: description, button: button, image: image) {
            EKWindowProvider.shared.dismiss()
        }
        
        let contentView = EKPopUpMessageView(with: message)
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        EKWindowProvider.shared.state = .message(view: contentView, attributes: attributes)
    }
    
    // Bumps a custom nib view
    private func showCustomNibView(attributes: EKAttributes) {
        EKWindowProvider.shared.state = .message(view: NibExampleView(), attributes: attributes)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension PresetsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EntryTableViewCell.self), for: indexPath) as! EntryTableViewCell
        cell.attributesDescription = dataSource[indexPath.section, indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SelectionHeaderView.className) as! SelectionHeaderView
        header.text = dataSource[section].title
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].data.count
    }
}

// MARK: Selection Helpers
extension PresetsViewController {
    
    private func toastCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            showNotificationMessage(attributes: attributes, textColor: .white, imageName: "ic_shopping_cart_light_32pt")
        case 1:
            showChatNotificationMessage(attributes: attributes)
        case 2:
            showNotificationMessage(attributes: attributes, textColor: .black, imageName: "ic_shopping_cart_dark_32pt")
        default:
            break
        }
    }
    
    private func noteCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            showNote(attributes: attributes)
        case 1:
            showProcessingNote(attributes: attributes)
        case 2:
            showStatusBarMessage(attributes: attributes)
        default:
            break
        }
    }
    
    private func floatCellSelected(with attributes: EKAttributes, row: Int) {
        
        switch row {
        case 0:
            showNotificationMessage(attributes: attributes, textColor: .white, imageName: "ic_shopping_cart_light_32pt")
        case 1:
            showNotificationMessage(attributes: attributes, textColor: .white, imageName: "ic_shopping_cart_light_32pt")
        default:
            break
        }
    }
    
    private func customCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            showAlertMessage(attributes: attributes)
        case 1:
            showCustomNibView(attributes: attributes)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let attributes = dataSource[indexPath.section, indexPath.row].attributes
        switch indexPath.section {
        case 0:
            toastCellSelected(with: attributes, row: indexPath.row)
        case 1:
            noteCellSelected(with: attributes, row: indexPath.row)
        case 2:
            floatCellSelected(with: attributes, row: indexPath.row)
        case 3:
            customCellSelected(with: attributes, row: indexPath.row)
        default:
            break
        }
    }
    
}
