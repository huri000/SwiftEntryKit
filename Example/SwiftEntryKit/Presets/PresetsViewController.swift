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
        let style = EKProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKNoteMessageView(with: labelContent)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showImageNote(attributes: EKAttributes) {
        
        // Set note label content
        let text = "The thrill is gone"
        let style = EKProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        let imageContent = EKProperty.ImageContent(image: UIImage(named: "ic_wifi")!)
        
        let contentView = EKImageNoteMessageView(with: labelContent, imageContent: imageContent)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps an infinate processing note
    private func showProcessingNote(attributes: EKAttributes) {
        let text = "Waiting for the goodies to arrive!"
        let style = EKProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: text, style: style)
        
        let contentView = EKProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a status bar replacement entry
    private func showStatusBarMessage(attributes: EKAttributes) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        
        let contentView: UIView
        let font = MainFont.light.with(size: 12)
        let labelStyle = EKProperty.LabelStyle(font: font, color: .white, alignment: .center)
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
    
    // Show rating view
    private func showRatingView(attributes: EKAttributes) {
        let unselectedImage = EKProperty.ImageContent(image: UIImage(named: "ic_star_unselected")!)
        let selectedImage = EKProperty.ImageContent(image: UIImage(named: "ic_star_selected")!)
        
        let initialTitle = EKProperty.LabelContent(text: "Rate our food", style: .init(font: MainFont.medium.with(size: 34), color: .black, alignment: .center))
        let initialDescription = EKProperty.LabelContent(text: "How was it?", style: .init(font: MainFont.light.with(size: 24), color: .gray, alignment: .center))
        
        let items = [("💩", "Pooish!"), ("🤨", "Ahhh?!"), ("👍", "OK!"), ("👌", "Tasty!"), ("😋", "Delicius!")].map { texts -> EKProperty.EKRatingItemContent in
            let itemTitle = EKProperty.LabelContent(text: texts.0, style: .init(font: MainFont.medium.with(size: 48), color: .black, alignment: .center))
            let itemDescription = EKProperty.LabelContent(text: texts.1, style: .init(font: MainFont.light.with(size: 24), color: .black, alignment: .center))
            return .init(title: itemTitle, description: itemDescription, unselectedImage: unselectedImage, selectedImage: selectedImage)
        }
    
        var message: EKRatingMessage!

        // Generate buttons content
        let lightFont = MainFont.light.with(size: 20)
        let mediumFont = MainFont.medium.with(size: 20)
        
        // Close button - Just dismiss entry when the button is tapped
        let grayColor = EKColor.Gray.a800
        let closeButtonLabelStyle = EKProperty.LabelStyle(font: mediumFont, color: grayColor)
        let closeButtonLabel = EKProperty.LabelContent(text: "Dismiss", style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  grayColor.withAlphaComponent(0.05)) {
            SwiftEntryKit.dismiss {
                // Here you may perform a completion handler
            }
        }
        
        // Ok Button - Make transition to a new entry when the button is tapped
        let pinkyColor = UIColor.pinky
        let okButtonLabelStyle = EKProperty.LabelStyle(font: lightFont, color: pinkyColor)
        let okButtonLabel = EKProperty.LabelContent(text: "Tell us more", style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  pinkyColor.withAlphaComponent(0.05)) {
            SwiftEntryKit.dismiss()
        }
    
        let buttonsBarContent = EKProperty.ButtonBarContent(with: closeButton, okButton, separatorColor: EKColor.Gray.light, buttonHeight: 60, expandAnimatedly: true)
        
        message = EKRatingMessage(initialTitle: initialTitle, initialDescription: initialDescription, ratingItems: items, buttonBarContent: buttonsBarContent) { index in
            // Rating selected - do something
        }
        
        let contentView = EKRatingMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a notification structured entry
    private func showNotificationMessage(attributes: EKAttributes, title: String, desc: String, textColor: UIColor, imageName: String? = nil) {
        let title = EKProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 16), color: textColor))
        let description = EKProperty.LabelContent(text: desc, style: .init(font: MainFont.light.with(size: 14), color: textColor))
        var image: EKProperty.ImageContent?
        if let imageName = imageName {
            image = .init(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
        }
        
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
    
    private func showPopupMessage(attributes: EKAttributes, title: String, titleColor: UIColor, description: String, descriptionColor: UIColor, buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, image: UIImage? = nil) {
        
        var themeImage: EKPopUpMessage.ThemeImage?
        
        if let image = image {
            themeImage = .init(image: .init(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit))
        }
        
        let title = EKProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 24), color: titleColor, alignment: .center))
        let description = EKProperty.LabelContent(text: description, style: .init(font: MainFont.light.with(size: 16), color: descriptionColor, alignment: .center))
        let button = EKProperty.ButtonContent(label: .init(text: "Got it!", style: .init(font: MainFont.bold.with(size: 16), color: buttonTitleColor)), backgroundColor: buttonBackgroundColor, highlightedBackgroundColor: buttonTitleColor.withAlphaComponent(0.05))
        let message = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
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
        let closeButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor.Gray.a800)
        let closeButtonLabel = EKProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor.Gray.a800.withAlphaComponent(0.05)) {
            SwiftEntryKit.dismiss()
        }
        
        // Ok Button - Make transition to a new entry when the button is tapped
        let okButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor.Teal.a600)
        let okButtonLabel = EKProperty.LabelContent(text: "SHOW ME", style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor.Teal.a600.withAlphaComponent(0.05)) { [unowned self] in
            var attributes = self.dataSource.bottomAlertAttributes
            attributes.entryBackground = .color(color: EKColor.Teal.a600)
            attributes.entranceAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 0.8, initialVelocity: 0)))
            let image = UIImage(named: "ic_success")!
            let title = "Congratz!"
            let description = "Your book coupon is 5w1ft3ntr1k1t"
            self.showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: description, descriptionColor: .white, buttonTitleColor: .darkSubText, buttonBackgroundColor: .white, image: image)
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
        let closeButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor.Gray.a800)
        let closeButtonLabel = EKProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor.Gray.a800.withAlphaComponent(0.05)) {
            SwiftEntryKit.dismiss()
        }
        
        // Remind me later Button
        let laterButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor.Teal.a600)
        let laterButtonLabel = EKProperty.LabelContent(text: "MAYBE LATER", style: laterButtonLabelStyle)
        let laterButton = EKProperty.ButtonContent(label: laterButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor.Teal.a600.withAlphaComponent(0.05)) {
            SwiftEntryKit.dismiss()
        }
        
        // Ok Button
        let okButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor.Teal.a600)
        let okButtonLabel = EKProperty.LabelContent(text: "SHOW ME", style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor.Teal.a600.withAlphaComponent(0.05)) {
            SwiftEntryKit.dismiss()
        }
        
        // Generate the content
        let buttonsBarContent = EKProperty.ButtonBarContent(with: okButton, laterButton, closeButton, separatorColor: EKColor.Gray.light, expandAnimatedly: true)
        
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, buttonBarContent: buttonsBarContent)

        // Setup the view itself
        let contentView = EKAlertMessageView(with: alertMessage)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a custom nib originated view
    private func showCustomNibView(attributes: EKAttributes) {
        SwiftEntryKit.display(entry: NibExampleView(), using: attributes)
    }
    
    // Bumps a custom view controller that is using a view from nib
    private func showCustomViewController(attributes: EKAttributes) {
        let viewController = ExampleViewController(with: NibExampleView())
        SwiftEntryKit.display(entry: viewController, using: attributes)
    }
    
    // Sign in form
    private func showSigninForm(attributes: EKAttributes, style: FormStyle) {
        let title = EKProperty.LabelContent(text: "Sign in to your account", style: style.title)
        let textFields = FormFieldPresetFactory.fields(by: [.email, .password], style: style)
        let button = EKProperty.ButtonContent(label: .init(text: "Continue", style: style.buttonTitle), backgroundColor: style.buttonBackground, highlightedBackgroundColor: style.buttonBackground.withAlphaComponent(0.8)) {
            SwiftEntryKit.dismiss()
        }
        let contentView = EKFormMessageView(with: title, textFieldsContent: textFields, buttonContent: button)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Sign up form
    private func showSignupForm(attributes: EKAttributes, style: FormStyle) {
        let title = EKProperty.LabelContent(text: "Fill your personal details", style: style.title)
        let textFields = FormFieldPresetFactory.fields(by: [.fullName, .mobile, .email, .password], style: style)
        let button = EKProperty.ButtonContent(label: .init(text: "Continue", style: style.buttonTitle), backgroundColor: style.buttonBackground, highlightedBackgroundColor: style.buttonBackground.withAlphaComponent(0.8)) {
            SwiftEntryKit.dismiss()
        }
        let contentView = EKFormMessageView(with: title, textFieldsContent: textFields, buttonContent: button)
        SwiftEntryKit.display(entry: contentView, using: attributes)
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
            formCellSelected(with: attributes, row: indexPath.row)
        case 5:
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
        case 3:
            let title = "Simple Notification-Like Message"
            let desc = "Robot moustache gentleman lip warmer nefarious, lip warmer robot moustache gentleman brandy crumb catcher groomed testosterone trophy nefarious, cappuccino collector testosterone trophy top gun testosterone trophy consectetur nefarious groomed brandy gentleman lip warmer robot moustache super mario crumb catcher. Toothbrush timothy dalton goose dali, louis xiii horseshoe mark lawrenson goose wario graeme souness tricky sneezes timothy dalton toothbrush louis xiii id dali?"
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .black)
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
        case 5:
            showRatingView(attributes: attributes)
        default:
            break
        }
    }
    
    private func formCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            showSigninForm(attributes: attributes, style: .light)
        case 1:
            showSignupForm(attributes: attributes, style: .light)
        case 2:
            showSignupForm(attributes: attributes, style: .dark)
        default:
            break
        }
    }
    
    private func customCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            showCustomNibView(attributes: attributes)
        case 1:
            showCustomViewController(attributes: attributes)
        default:
            break
        }
    }
}
