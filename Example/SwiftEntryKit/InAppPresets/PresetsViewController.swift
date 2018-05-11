//
//  PresetsViewController.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import SwiftEntryKit
import UIKit

/** This view controller offers presets of entries to choose from */
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
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(PresetTableViewCell.self, forCellReuseIdentifier: PresetTableViewCell.className)
        tableView.register(SelectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SelectionHeaderView.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fillSuperview()
    }
    
    // MARK: Entry Samples
    
    // Bumps a standard note
    private func showNote(attributes: EKAttributes) {
        let text = "Pssst! I have something to tell you..."
        let style = EKProperty.Label(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKNoteMessageView(with: labelContent)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showImageNote(attributes: EKAttributes) {
        
        // Set note label content
        let text = "The thrill is gone"
        let style = EKProperty.Label(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        let imageContent = EKProperty.ImageContent(image: UIImage(named: "ic_wifi")!)
        
        let contentView = EKImageNoteMessageView(with: labelContent, imageContent: imageContent)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps an infinate processing note
    private func showProcessingNote(attributes: EKAttributes) {
        let text = "Waiting for the goodies to arrive!"
        let style = EKProperty.Label(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a status bar replacement entry
    private func showStatusBarMessage(attributes: EKAttributes) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        
        let contentView: UIView
        let font = MainFont.light.with(size: 12)
        let labelStyle = EKProperty.Label(font: font, color: .white, alignment: .center)
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
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a notification structured entry
    private func showNotificationMessage(attributes: EKAttributes, title: String, desc: String, textColor: UIColor, imageName: String) {
        let title = EKProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 16), color: textColor))
        let description = EKProperty.LabelContent(text: desc, style: .init(font: MainFont.light.with(size: 14), color: textColor))
        let image = EKProperty.ImageContent(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)

        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a chat message structured entry
    private func showChatNotificationMessage(attributes: EKAttributes) {
        let title = EKProperty.LabelContent(text: "Madi", style: .init(font: MainFont.medium.with(size: 14), color: .white))
        let description = EKProperty.LabelContent(text: "Hey! I'll come by at your office for lunch... 🍲", style: .init(font: MainFont.light.with(size: 12), color: .white))
        let time = EKProperty.LabelContent(text: "09:00", style: .init(font: MainFont.light.with(size: 10), color: .white))
        let image = EKProperty.ImageContent.thumb(with: "ic_madi_profile", edgeSize: 35)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage, auxiliary: time)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showDarkAwesomePopupMessage(attributes: EKAttributes) {
        let image = UIImage(named: "ic_done_all_dark_48pt")!
        let title = "Awesome!"
        let description = "You are using SwiftEntryKit, and this is a customized alert view that is floating at the bottom."
        showPopupMessage(attributes: attributes, title: title, titleColor: .darkText, description: description, descriptionColor: .darkSubText, buttonTitleColor: .white, buttonBackgroundColor: .amber, image: image)
    }
    
    private func showLightAwesomePopupMessage(attributes: EKAttributes) {
        let image = UIImage(named: "ic_done_all_light_48pt")!
        let title = "Awesome!"
        let description = "You are using SwiftEntryKit, and this is a pop up with important content"
        showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: description, descriptionColor: .white, buttonTitleColor: EKColor.Gray.mid, buttonBackgroundColor: .white, image: image)
    }
    
    private func showPopupMessage(attributes: EKAttributes, title: String, titleColor: UIColor, description: String, descriptionColor: UIColor, buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, image: UIImage, imagePosition: EKPopUpMessage.ImagePosition = .topToTop(offset: 40)) {
        let title = EKProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 24), color: titleColor, alignment: .center))
        let description = EKProperty.LabelContent(text: description, style: .init(font: MainFont.light.with(size: 16), color: descriptionColor, alignment: .center))
        let button = EKProperty.ButtonContent(label: .init(text: "Got it!", style: .init(font: MainFont.bold.with(size: 16), color: buttonTitleColor)), backgroundColor: buttonBackgroundColor)
        let topImage = EKProperty.ImageContent(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit)
        let message = EKPopUpMessage(topImage: topImage, imagePosition: imagePosition, title: title, description: description, button: button) {
            SwiftEntryKit.dismiss()
        }
        
        let contentView = EKPopUpMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showButtonBarMessage(attributes: EKAttributes) {
        
        // Generate textual content
        let title = EKProperty.LabelContent(text: "Dear Reader!", style: .init(font: MainFont.medium.with(size: 15), color: .black))
        let description = EKProperty.LabelContent(text: "Get a coupon for a free book now", style: .init(font: MainFont.light.with(size: 13), color: .black))
        let image = EKProperty.ImageContent(imageName: "ic_books", size: CGSize(width: 35, height: 35), contentMode: .scaleAspectFit)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        
        // Generate buttons content
        let buttonFont = MainFont.medium.with(size: 16)
        
        // Close button - Just dismiss entry when the button is tapped
        let closeButtonLabelStyle = EKProperty.Label(font: buttonFont, color: EKColor.Gray.a800)
        let closeButtonLabel = EKProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear) {
            SwiftEntryKit.dismiss()
        }
        
        // Ok Button - Make transition to a new entry when the button is tapped
        let okButtonLabelStyle = EKProperty.Label(font: buttonFont, color: EKColor.Teal.a600)
        let okButtonLabel = EKProperty.LabelContent(text: "SHOW ME", style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear) { [unowned self] in
            var attributes = self.dataSource.bottomAlertAttributes
            attributes.entryBackground = .color(color: EKColor.Teal.a600)
            attributes.entranceAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 0.8, initialVelocity: 0)))
            let image = UIImage(named: "ic_success")!
            let title = "Congratz!"
            let description = "Your book coupon is 5w1ft3ntr1k1t"
            self.showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: description, descriptionColor: .white, buttonTitleColor: .darkSubText, buttonBackgroundColor: .white, image: image, imagePosition: .topToTop(offset: 25))
        }
        let buttonsBarContent = EKProperty.ButtonBarContent(with: closeButton, okButton, separatorColor: EKColor.Gray.light, expandAnimatedly: true)
        
        // Generate the content
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, imagePosition: .left, buttonBarContent: buttonsBarContent)
        
        let contentView = EKAlertMessageView(with: alertMessage)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showAlertView(attributes: EKAttributes) {
        
        // Generate textual content
        let title = EKProperty.LabelContent(text: "Hopa!", style: .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center))
        let description = EKProperty.LabelContent(text: "This is a system-like alert, with several buttons. You can display even more buttons if you want. Click on one of them to dismiss it.", style: .init(font: MainFont.light.with(size: 13), color: .black, alignment: .center))
        let image = EKProperty.ImageContent(imageName: "ic_apple", size: CGSize(width: 25, height: 25), contentMode: .scaleAspectFit)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        
        // Generate buttons content
        let buttonFont = MainFont.medium.with(size: 16)
        
        // Close button
        let closeButtonLabelStyle = EKProperty.Label(font: buttonFont, color: EKColor.Gray.a800)
        let closeButtonLabel = EKProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear) {
            SwiftEntryKit.dismiss()
        }
        
        // Remind me later Button
        let laterButtonLabelStyle = EKProperty.Label(font: buttonFont, color: EKColor.Teal.a600)
        let laterButtonLabel = EKProperty.LabelContent(text: "MAYBE LATER", style: laterButtonLabelStyle)
        let laterButton = EKProperty.ButtonContent(label: laterButtonLabel, backgroundColor: .clear) {
            SwiftEntryKit.dismiss()
        }
        
        // Ok Button
        let okButtonLabelStyle = EKProperty.Label(font: buttonFont, color: EKColor.Teal.a600)
        let okButtonLabel = EKProperty.LabelContent(text: "SHOW ME", style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear) {
            SwiftEntryKit.dismiss()
        }
        
        // Generate the content
        let buttonsBarContent = EKProperty.ButtonBarContent(with: okButton, laterButton, closeButton, separatorColor: EKColor.Gray.light, expandAnimatedly: true)
        
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, buttonBarContent: buttonsBarContent)

        // Setup the view itself
        let contentView = EKAlertMessageView(with: alertMessage)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a custom nib view
    private func showCustomNibView(attributes: EKAttributes) {
        SwiftEntryKit.display(entry: NibExampleView(), using: attributes)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension PresetsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            popupCellSelected(with: attributes, row: indexPath.row)
        case 4:
            customCellSelected(with: attributes, row: indexPath.row)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PresetTableViewCell.className, for: indexPath) as! PresetTableViewCell
        cell.presetDescription = dataSource[indexPath.section, indexPath.row]
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
    
    // iOS 9, 10 support
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

// MARK: Selection Helpers
extension PresetsViewController {
    
    private func toastCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            let title = "Mail Received!"
            let desc = "Daniel sent you a message"
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .white, imageName: "paper-plane-light")
        case 1:
            showChatNotificationMessage(attributes: attributes)
        case 2:
            let title = "15% Discount!"
            let desc = "Receive your coupon for 15% discount at Swifty Kitty Bakery"
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .black, imageName: "ic_pizza")
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
            showImageNote(attributes: attributes)
        case 3:
            showStatusBarMessage(attributes: attributes)
        case 4:
            showNote(attributes: attributes)
        default:
            break
        }
    }
    
    private func floatCellSelected(with attributes: EKAttributes, row: Int) {
        let title = "Kofi Shop"
        let desc = "Over two weeks of quality coffee beans concentrated into a single entry kit"
        let image = "ic_coffee_light"
        switch row {
        case 0:
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .white, imageName: image)
        case 1:
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .white, imageName: image)
        default:
            break
        }
    }
    
    private func popupCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            showDarkAwesomePopupMessage(attributes: attributes)
        case 1:
            showLightAwesomePopupMessage(attributes: attributes)
        case 2:
            showLightAwesomePopupMessage(attributes: attributes)
        case 3:
            showButtonBarMessage(attributes: attributes)
        case 4:
            showAlertView(attributes: attributes)
        default:
            break
        }
    }
    
    private func customCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            showCustomNibView(attributes: attributes)
        default:
            break
        }
    }
}
