//
//  PresetsViewController.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import SwiftEntryKit
import UIKit

/** This view controller offers presets to choose from */
class PresetsViewController: UIViewController {
    
    enum DisplayModeSegment: Int {
        case light
        case dark
        case inferred
        
        var displayMode: EKAttributes.DisplayMode {
            switch self {
            case .light:
                return .light
            case .dark:
                return .dark
            case .inferred:
                return .inferred
            }
        }
    }
    
    // MARK: - Properties
    
    private var displayMode: EKAttributes.DisplayMode {
        return PresetsDataSource.displayMode
    }
    
    private var dataSource = PresetsDataSource()
    private let tableView = UITableView()
    @IBOutlet private var displayModeSegmentedControl: UISegmentedControl!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch PresetsDataSource.displayMode {
        case .dark:
            return .lightContent
        case .light:
            if #available(iOS 13, *) {
                return .darkContent
            } else {
                return .default
            }
        case .inferred:
            return super.preferredStatusBarStyle
        }
    }
    
    // MARK: - Lifecycle & Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterfaceStyle()
        setupTableView()
        displayModeSegmentedControl.selectedSegmentIndex = DisplayModeSegment.inferred.rawValue
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
    
    @IBAction private func displayModeSegmentedControlValueChanged() {
        guard let segment = DisplayModeSegment(rawValue: displayModeSegmentedControl.selectedSegmentIndex) else {
            return
        }
        PresetsDataSource.displayMode = segment.displayMode
        dataSource.setup()
        setupInterfaceStyle()
        tableView.reloadData()
    }
    
    private func setupInterfaceStyle() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: EKColor.standardContent.color(
                for: traitCollection,
                mode: PresetsDataSource.displayMode
            )
        ]
        navigationController?.navigationBar.tintColor = EKColor.navigationItemColor.color(
            for: traitCollection,
            mode: PresetsDataSource.displayMode
        )
        navigationController?.navigationBar.barTintColor = EKColor.navigationBackgroundColor.color(
            for: traitCollection,
            mode: PresetsDataSource.displayMode
        )
        displayModeSegmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor:
                EKColor.standardContent.color(
                    for: traitCollection,
                    mode: PresetsDataSource.displayMode
                )
            ],
            for: .normal
        )
        displayModeSegmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor:
                EKColor.standardContent.color(
                    for: traitCollection,
                    mode: PresetsDataSource.displayMode
                )
            ],
            for: .selected
        )
        displayModeSegmentedControl.tintColor = EKColor.selectedBackground.color(
            for: traitCollection,
            mode: PresetsDataSource.displayMode
        )
        view.backgroundColor = EKColor.standardBackground.color(
            for: traitCollection,
            mode: PresetsDataSource.displayMode
        )
        tableView.backgroundColor = EKColor.standardBackground.color(
            for: traitCollection,
            mode: PresetsDataSource.displayMode
        )
        tableView.separatorColor = EKColor.standardContent.with(alpha: 0.3).color(
            for: traitCollection,
            mode: PresetsDataSource.displayMode
        )
        // Just in case view-controller-based-status-bar-appearance is being tinkered with
        UIApplication.shared.statusBarStyle = preferredStatusBarStyle
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        tableView.register(
            PresetTableViewCell.self,
            forCellReuseIdentifier: PresetTableViewCell.className
        )
        tableView.register(
            SelectionHeaderView.self,
            forHeaderFooterViewReuseIdentifier: SelectionHeaderView.className
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fillSuperview()
    }
    
    // MARK: Entry Samples
    
    // Bumps a standard note
    private func showNote(attributes: EKAttributes) {
        let text = "Pssst! I have something to tell you..."
        let style = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 14),
            color: .white,
            alignment: .center
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        let contentView = EKNoteMessageView(with: labelContent)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showImageNote(attributes: EKAttributes) {
        let text = "The thrill is gone"
        let style = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 14),
            color: .white,
            alignment: .center,
            displayMode: displayMode
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        let imageContent = EKProperty.ImageContent(
            image: UIImage(named: "ic_wifi")!,
            displayMode: displayMode
        )
        let contentView = EKImageNoteMessageView(
            with: labelContent,
            imageContent: imageContent
        )
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showAnimatingImageNote(attributes: EKAttributes) {
        let text = "Up and charge"
        let style = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 14),
            color: .black,
            alignment: .center,
            displayMode: displayMode
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        let sequence = (0...5).map { "battery\($0)" }
        let animationDuration: TimeInterval = 1
        let animation = EKProperty.ImageContent.TransformAnimation.animate(
            duration: animationDuration,
            options: [.curveEaseInOut],
            transform: .init(scaleX: 1.1, y: 1.1)
        )
        let imageContent = EKProperty.ImageContent(
            imagesNames: sequence,
            imageSequenceAnimationDuration: animationDuration,
            displayMode: displayMode,
            animation: animation,
            size: CGSize(width: 16, height: 16),
            tint: .black,
            contentMode: .scaleAspectFit
        )
        let contentView = EKImageNoteMessageView(
            with: labelContent,
            imageContent: imageContent
        )
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showProcessingNote(attributes: EKAttributes) {
        let text = "Waiting for the goodies to arrive!"
        let style = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 14),
            color: .white,
            alignment: .center,
            displayMode: displayMode
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        let contentView = EKProcessingNoteMessageView(
            with: labelContent,
            activityIndicator: .white
        )
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a status bar replacement entry
    private func showStatusBarMessage(attributes: EKAttributes) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        let contentView: UIView
        let font = MainFont.light.with(size: 12)
        let labelStyle = EKProperty.LabelStyle(
            font: font,
            color: .white,
            alignment: .center,
            displayMode: displayMode
        )
        if statusBarHeight > 20 {
            let leading = EKProperty.LabelContent(
                text: "My 🧠",
                style: labelStyle
            )
            let trailing = EKProperty.LabelContent(
                text: "Wonders!",
                style: labelStyle
            )
            contentView = EKXStatusBarMessageView(
                leading: leading,
                trailing: trailing
            )
        } else {
            let labelContent = EKProperty.LabelContent(
                text: "My 🧠 is doing some thinking...",
                style: labelStyle
            )
            let noteView = EKNoteMessageView(with: labelContent)
            noteView.verticalOffset = 0
            noteView.set(.height, of: statusBarHeight)
            contentView = noteView
        }
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Show rating view
    private func showRatingView(attributes: EKAttributes) {
        let unselectedImage = EKProperty.ImageContent(
            image: UIImage(named: "ic_star_unselected")!.withRenderingMode(.alwaysTemplate),
            displayMode: displayMode,
            tint: .standardContent
        )
        let selectedImage = EKProperty.ImageContent(
            image: UIImage(named: "ic_star_selected")!.withRenderingMode(.alwaysTemplate),
            displayMode: displayMode,
            tint: EKColor.ratingStar
        )
        let initialTitle = EKProperty.LabelContent(
            text: "Rate our food",
            style: .init(
                font: MainFont.medium.with(size: 34),
                color: .standardContent,
                alignment: .center,
                displayMode: displayMode
            )
        )
        let initialDescription = EKProperty.LabelContent(
            text: "How was it?",
            style: .init(
                font: MainFont.light.with(size: 24),
                color: EKColor.standardContent.with(alpha: 0.5),
                alignment: .center,
                displayMode: displayMode
            )
        )
        let items = [("💩", "Pooish!"), ("🤨", "Ahhh?!"), ("👍", "OK!"),
                     ("👌", "Tasty!"), ("😋", "Delicius!")].map { texts -> EKProperty.EKRatingItemContent in
                        let itemTitle = EKProperty.LabelContent(
                            text: texts.0,
                            style: .init(
                                font: MainFont.medium.with(size: 48),
                                color: .standardContent,
                                alignment: .center,
                                displayMode: displayMode
                            )
                        )
                        let itemDescription = EKProperty.LabelContent(
                            text: texts.1,
                            style: .init(
                                font: MainFont.light.with(size: 24),
                                color: .standardContent,
                                alignment: .center,
                                displayMode: displayMode
                            )
                        )
                        return EKProperty.EKRatingItemContent(
                            title: itemTitle,
                            description: itemDescription,
                            unselectedImage: unselectedImage,
                            selectedImage: selectedImage
                        )
        }
        
        var message: EKRatingMessage!
        let lightFont = MainFont.light.with(size: 20)
        let mediumFont = MainFont.medium.with(size: 20)
        let closeButtonLabelStyle = EKProperty.LabelStyle(
            font: mediumFont,
            color: .standardContent,
            displayMode: displayMode
        )
        let closeButtonLabel = EKProperty.LabelContent(
            text: "Dismiss",
            style: closeButtonLabelStyle
        )
        let closeButton = EKProperty.ButtonContent(
            label: closeButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: EKColor.standardBackground.with(alpha: 0.2),
            displayMode: displayMode) {
                SwiftEntryKit.dismiss {
                    // Here you may perform a completion handler
                }
        }
        
        let pinkyColor = EKColor.pinky
        let okButtonLabelStyle = EKProperty.LabelStyle(
            font: lightFont,
            color: pinkyColor,
            displayMode: displayMode
        )
        let okButtonLabel = EKProperty.LabelContent(
            text: "Tell us more",
            style: okButtonLabelStyle
        )
        let okButton = EKProperty.ButtonContent(
            label: okButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: pinkyColor.with(alpha: 0.05),
            displayMode: displayMode) {
                SwiftEntryKit.dismiss()
        }
        let buttonsBarContent = EKProperty.ButtonBarContent(
            with: closeButton, okButton,
            separatorColor: EKColor(light: Color.Gray.light.light, dark: Color.Gray.mid.light),
            horizontalDistributionThreshold: 1,
            displayMode: displayMode,
            expandAnimatedly: true
        )
        message = EKRatingMessage(
            initialTitle: initialTitle,
            initialDescription: initialDescription,
            ratingItems: items,
            buttonBarContent: buttonsBarContent) { index in
                // Rating selected - do something
        }
        let contentView = EKRatingMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a notification structured entry
    private func showNotificationMessage(attributes: EKAttributes,
                                         title: String,
                                         desc: String,
                                         textColor: EKColor,
                                         imageName: String? = nil) {
        let title = EKProperty.LabelContent(
            text: title,
            style: .init(
                font: MainFont.medium.with(size: 16),
                color: textColor,
                displayMode: displayMode
            ),
            accessibilityIdentifier: "title"
        )
        let description = EKProperty.LabelContent(
            text: desc,
            style: .init(
                font: MainFont.light.with(size: 14),
                color: textColor,
                displayMode: displayMode
            ),
            accessibilityIdentifier: "description"
        )
        var image: EKProperty.ImageContent?
        if let imageName = imageName {
            image = EKProperty.ImageContent(
                image: UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate),
                displayMode: displayMode,
                size: CGSize(width: 35, height: 35),
                tint: textColor,
                accessibilityIdentifier: "thumbnail"
            )
        }
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: title,
            description: description
        )
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a chat message structured entry
    private func showChatNotificationMessage(attributes: EKAttributes) {
        let title = EKProperty.LabelContent(
            text: "Madi",
            style: .init(
                font: MainFont.medium.with(size: 14),
                color: .white,
                displayMode: displayMode
            )
        )
        let description = EKProperty.LabelContent(
            text: "Hey! I'll come by at your office for lunch... 🍲",
            style: .init(
                font: MainFont.light.with(size: 12),
                color: .white,
                displayMode: displayMode
            )
        )
        let time = EKProperty.LabelContent(
            text: "09:00",
            style: .init(
                font: MainFont.light.with(size: 10),
                color: .white,
                displayMode: displayMode
            )
        )
        let image = EKProperty.ImageContent.thumb(
            with: "ic_madi_profile",
            edgeSize: 35
        )
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: title,
            description: description
        )
        let notificationMessage = EKNotificationMessage(
            simpleMessage: simpleMessage,
            auxiliary: time
        )
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showDarkAwesomePopupMessage(attributes: EKAttributes) {
        let image = UIImage(named: "ic_done_all_dark_48pt")!.withRenderingMode(.alwaysTemplate)
        let title = "Awesome!"
        let description =
        """
        You are using SwiftEntryKit, \
        and this is a customized alert \
        view that is floating at the bottom.
        """
        showPopupMessage(attributes: attributes,
                         title: title,
                         titleColor: .text,
                         description: description,
                         descriptionColor: .subText,
                         buttonTitleColor: .white,
                         buttonBackgroundColor: .amber,
                         image: image)
    }
    
    private func showLightAwesomePopupMessage(attributes: EKAttributes) {
        let image = UIImage(named: "ic_done_all_light_48pt")!.withRenderingMode(.alwaysTemplate)
        let title = "Awesome!"
        let description = "You are using SwiftEntryKit, and this is a pop up with important content"
        showPopupMessage(attributes: attributes,
                         title: title,
                         titleColor: .white,
                         description: description,
                         descriptionColor: .white,
                         buttonTitleColor: Color.Gray.mid,
                         buttonBackgroundColor: .white,
                         image: image)
    }
    
    private func showPopupMessage(attributes: EKAttributes,
                                  title: String,
                                  titleColor: EKColor,
                                  description: String,
                                  descriptionColor: EKColor,
                                  buttonTitleColor: EKColor,
                                  buttonBackgroundColor: EKColor,
                                  image: UIImage? = nil) {
        
        var themeImage: EKPopUpMessage.ThemeImage?
        
        if let image = image {
            themeImage = EKPopUpMessage.ThemeImage(
                image: EKProperty.ImageContent(
                    image: image,
                    displayMode: displayMode,
                    size: CGSize(width: 60, height: 60),
                    tint: titleColor,
                    contentMode: .scaleAspectFit
                )
            )
        }
        let title = EKProperty.LabelContent(
            text: title,
            style: .init(
                font: MainFont.medium.with(size: 24),
                color: titleColor,
                alignment: .center,
                displayMode: displayMode
            )
        )
        let description = EKProperty.LabelContent(
            text: description,
            style: .init(
                font: MainFont.light.with(size: 16),
                color: descriptionColor,
                alignment: .center,
                displayMode: displayMode
            )
        )
        let button = EKProperty.ButtonContent(
            label: .init(
                text: "Got it!",
                style: .init(
                    font: MainFont.bold.with(size: 16),
                    color: buttonTitleColor,
                    displayMode: displayMode
                )
            ),
            backgroundColor: buttonBackgroundColor,
            highlightedBackgroundColor: buttonTitleColor.with(alpha: 0.05),
            displayMode: displayMode
        )
        let message = EKPopUpMessage(
            themeImage: themeImage,
            title: title,
            description: description,
            button: button) {
                SwiftEntryKit.dismiss()
        }
        let contentView = EKPopUpMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showButtonBarMessage(attributes: EKAttributes) {
        let title = EKProperty.LabelContent(
            text: "Dear Reader!",
            style: .init(
                font: MainFont.medium.with(size: 15),
                color: .black,
                displayMode: displayMode
            )
        )
        let description = EKProperty.LabelContent(
            text: "Get your coupon for a free book now",
            style: .init(
                font: MainFont.light.with(size: 13),
                color: .black,
                displayMode: displayMode
            )
        )
        let image = EKProperty.ImageContent(
            imageName: "ic_books",
            displayMode: displayMode,
            size: CGSize(width: 35, height: 35),
            contentMode: .scaleAspectFit
        )
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: title,
            description: description
        )
        let buttonFont = MainFont.medium.with(size: 16)
        let closeButtonLabelStyle = EKProperty.LabelStyle(
            font: buttonFont,
            color: Color.Gray.a800,
            displayMode: displayMode
        )
        let closeButtonLabel = EKProperty.LabelContent(
            text: "NOT NOW",
            style: closeButtonLabelStyle
        )
        let closeButton = EKProperty.ButtonContent(
            label: closeButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: Color.Gray.a800.with(alpha: 0.05)) {
                SwiftEntryKit.dismiss()
        }
        let okButtonLabelStyle = EKProperty.LabelStyle(
            font: buttonFont,
            color: Color.Teal.a600,
            displayMode: displayMode
        )
        let okButtonLabel = EKProperty.LabelContent(
            text: "LET ME HAVE IT",
            style: okButtonLabelStyle
        )
        let okButton = EKProperty.ButtonContent(
            label: okButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: Color.Teal.a600.with(alpha: 0.05),
            displayMode: displayMode) { [unowned self] in
                var attributes = self.dataSource.bottomAlertAttributes
                attributes.entryBackground = .color(color: Color.Teal.a600)
                attributes.entranceAnimation = .init(
                    translate: .init(duration: 0.65, spring: .init(damping: 0.8, initialVelocity: 0))
                )
                let image = UIImage(named: "ic_success")!
                let title = "Congratz!"
                let description = "Your book coupon is 5w1ft3ntr1k1t"
                self.showPopupMessage(attributes: attributes,
                                      title: title,
                                      titleColor: .white,
                                      description: description,
                                      descriptionColor: .white,
                                      buttonTitleColor: .subText,
                                      buttonBackgroundColor: .white,
                                      image: image)
        }
        let buttonsBarContent = EKProperty.ButtonBarContent(
            with: closeButton, okButton,
            separatorColor: Color.Gray.light,
            buttonHeight: 60,
            displayMode: displayMode,
            expandAnimatedly: true
        )
        let alertMessage = EKAlertMessage(
            simpleMessage: simpleMessage,
            imagePosition: .left,
            buttonBarContent: buttonsBarContent
        )
        let contentView = EKAlertMessageView(with: alertMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    private func showAlertView(attributes: EKAttributes) {
        let title = EKProperty.LabelContent(
            text: "Hopa!",
            style: .init(
                font: MainFont.medium.with(size: 15),
                color: .black,
                alignment: .center,
                displayMode: displayMode
            )
        )
        let text =
        """
        This is a system-like alert, with several buttons. \
        You can display even more buttons if you want. \
        Click on one of them to dismiss it.
        """
        let description = EKProperty.LabelContent(
            text: text,
            style: .init(
                font: MainFont.light.with(size: 13),
                color: .black,
                alignment: .center,
                displayMode: displayMode
            )
        )
        let image = EKProperty.ImageContent(
            imageName: "ic_apple",
            displayMode: displayMode,
            size: CGSize(width: 25, height: 25),
            contentMode: .scaleAspectFit
        )
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: title,
            description: description
        )
        let buttonFont = MainFont.medium.with(size: 16)
        let closeButtonLabelStyle = EKProperty.LabelStyle(
            font: buttonFont,
            color: Color.Gray.a800,
            displayMode: displayMode
        )
        let closeButtonLabel = EKProperty.LabelContent(
            text: "NOT NOW",
            style: closeButtonLabelStyle
        )
        let closeButton = EKProperty.ButtonContent(
            label: closeButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: Color.Gray.a800.with(alpha: 0.05),
            displayMode: displayMode) {
                SwiftEntryKit.dismiss()
        }
        let laterButtonLabelStyle = EKProperty.LabelStyle(
            font: buttonFont,
            color: Color.Teal.a600,
            displayMode: displayMode
        )
        let laterButtonLabel = EKProperty.LabelContent(
            text: "MAYBE LATER",
            style: laterButtonLabelStyle
        )
        let laterButton = EKProperty.ButtonContent(
            label: laterButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: Color.Teal.a600.with(alpha: 0.05),
            displayMode: displayMode) {
                SwiftEntryKit.dismiss()
        }
        let okButtonLabelStyle = EKProperty.LabelStyle(
            font: buttonFont,
            color: Color.Teal.a600,
            displayMode: displayMode
        )
        let okButtonLabel = EKProperty.LabelContent(
            text: "SHOW ME",
            style: okButtonLabelStyle
        )
        let okButton = EKProperty.ButtonContent(
            label: okButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: Color.Teal.a600.with(alpha: 0.05),
            displayMode: displayMode) {
                SwiftEntryKit.dismiss()
        }
        // Generate the content
        let buttonsBarContent = EKProperty.ButtonBarContent(
            with: okButton, laterButton, closeButton,
            separatorColor: Color.Gray.light,
            displayMode: displayMode,
            expandAnimatedly: true
        )
        let alertMessage = EKAlertMessage(
            simpleMessage: simpleMessage,
            buttonBarContent: buttonsBarContent
        )
        let contentView = EKAlertMessageView(with: alertMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Bumps a navigation controller
    private func showNavigationController(with attributes: EKAttributes) {
        let viewController = ContactsViewController()
        let navigationController = ExampleNavigationViewController(rootViewController: viewController)
        SwiftEntryKit.display(entry: navigationController, using: attributes)
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
        let titleStyle = EKProperty.LabelStyle(
            font: MainFont.medium.with(size: 16),
            color: .standardContent,
            alignment: .center,
            displayMode: displayMode
        )
        let title = EKProperty.LabelContent(
            text: "Sign in to your account",
            style: titleStyle
        )
        let textFields = FormFieldPresetFactory.fields(
            by: [.email, .password],
            style: style
        )
        let button = EKProperty.ButtonContent(
            label: .init(text: "Continue", style: style.buttonTitle),
            backgroundColor: style.buttonBackground,
            highlightedBackgroundColor: style.buttonBackground.with(alpha: 0.8),
            displayMode: displayMode,
            accessibilityIdentifier: "continueButton") {
                SwiftEntryKit.dismiss()
        }
        let contentView = EKFormMessageView(
            with: title,
            textFieldsContent: textFields,
            buttonContent: button
        )
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Sign up form
    private func showSignupForm(attributes: inout EKAttributes, style: FormStyle) {
        let titleStyle = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 14),
            color: style.textColor,
            displayMode: displayMode
        )
        let title = EKProperty.LabelContent(
            text: "Fill your personal details",
            style: titleStyle
        )
        let textFields = FormFieldPresetFactory.fields(
            by: [.fullName, .mobile, .email, .password],
            style: style
        )
        let button = EKProperty.ButtonContent(
            label: .init(text: "Continue", style: style.buttonTitle),
            backgroundColor: style.buttonBackground,
            highlightedBackgroundColor: style.buttonBackground.with(alpha: 0.8),
            displayMode: displayMode) {
                SwiftEntryKit.dismiss()
        }
        let contentView = EKFormMessageView(
            with: title,
            textFieldsContent: textFields,
            buttonContent: button
        )
        attributes.lifecycleEvents.didAppear = {
            contentView.becomeFirstResponder(with: 0)
        }
        SwiftEntryKit.display(entry: contentView, using: attributes, presentInsideKeyWindow: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

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
        case 6:
            showNavigationController(with: attributes)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PresetTableViewCell.className,
                                                 for: indexPath) as! PresetTableViewCell
        cell.presetDescription = dataSource[indexPath.section, indexPath.row]
        cell.displayMode = PresetsDataSource.displayMode
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SelectionHeaderView.className) as! SelectionHeaderView
        header.text = dataSource[section].title
        header.displayMode = PresetsDataSource.displayMode
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].data.count
    }
    
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
            showNotificationMessage(attributes: attributes,
                                    title: title,
                                    desc: desc,
                                    textColor: .white,
                                    imageName: "paper-plane-light")
        case 1:
            showChatNotificationMessage(attributes: attributes)
        case 2:
            let title = "15% Discount!"
            let desc = "Receive your coupon for 15% discount at Swifty Kitty Bakery"
            showNotificationMessage(attributes: attributes,
                                    title: title,
                                    desc: desc,
                                    textColor: .standardContent,
                                    imageName: "ic_pizza")
        case 3:
            let title = "Simple Notification-Like Message"
            let desc =
            """
            Robot moustache gentleman lip warmer nefarious, lip warmer robot moustache gentleman brandy crumb catcher groomed testosterone trophy nefarious, cappuccino collector testosterone trophy top gun testosterone trophy consectetur nefarious groomed brandy gentleman lip warmer robot moustache super mario crumb catcher. Toothbrush timothy dalton goose dali, louis xiii horseshoe mark lawrenson goose wario graeme souness tricky sneezes timothy dalton toothbrush louis xiii id dali?
            """
            showNotificationMessage(attributes: attributes,
                                    title: title,
                                    desc: desc,
                                    textColor: .standardContent)
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
            showAnimatingImageNote(attributes: attributes)
        case 4:
            showStatusBarMessage(attributes: attributes)
        case 5:
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
            showNotificationMessage(attributes: attributes,
                                    title: title,
                                    desc: desc,
                                    textColor: .white,
                                    imageName: image)
        case 1:
            showNotificationMessage(attributes: attributes,
                                    title: title,
                                    desc: desc,
                                    textColor: .white,
                                    imageName: image)
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
            var attributes = attributes
            showSignupForm(attributes: &attributes, style: .light)
        case 2:
            var attributes = attributes
            showSignupForm(attributes: &attributes, style: .metallic)
        default:
            break
        }
    }
    
    private func customCellSelected(with attributes: EKAttributes, row: Int) {
        switch row {
        case 0:
            showNavigationController(with: attributes)
        case 1:
            showCustomNibView(attributes: attributes)
        case 2:
            showCustomViewController(attributes: attributes)
        default:
            break
        }
    }
}
