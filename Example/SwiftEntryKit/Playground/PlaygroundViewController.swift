//
//  ComposeViewController.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

class PlaygroundViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private lazy var attributesWrapper: EntryAttributeWrapper = {
        var attributes = EKAttributes()
        attributes.positionConstraints = .full
        attributes.hapticFeedbackType = .success
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.entryBackground = .visualEffect(style: .light)
        return EntryAttributeWrapper(with: attributes)
    }()
    
    struct Cells {
        
        static let sectionTitles = ["Display", "Theme & Style", "Interaction", "Size & Position", "Animation"]
        
        static let header = SelectionHeaderView.self
        
        static let cells = [[PositionSelectionTableViewCell.self,
                            WindowLevelSelectionTableViewCell.self,
                            DisplayDurationSelectionTableViewCell.self,
                            PrioritySelectionTableViewCell.self],
                            
                            [ShadowSelectionTableViewCell.self,
                            RoundCornersSelectionTableViewCell.self,
                            BorderSelectionTableViewCell.self,
                            BackgroundStyleSelectionTableViewCell.self,
                            BackgroundStyleSelectionTableViewCell.self],
                            
                            [UserInteractionSelectionTableViewCell.self,
                            UserInteractionSelectionTableViewCell.self,
                            ScrollSelectionTableViewCell.self,
                            HapticFeedbackSelectionTableViewCell.self],
                            
                            [WidthSelectionTableViewCell.self,
                            HeightSelectionTableViewCell.self,
                            MaxWidthSelectionTableViewCell.self,
                            SafeAreaSelectionTableViewCell.self],
                            
                            [AnimationSelectionTableViewCell.self,
                            AnimationSelectionTableViewCell.self,
                            AnimationSelectionTableViewCell.self]]
    }
    
    // MARK: Lifecycle & Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(Cells.header, forHeaderFooterViewReuseIdentifier: Cells.header.className)
        Cells.cells.forEach { cells in
            cells.forEach { tableView.register($0, forCellReuseIdentifier: $0.className) }
        }
        tableView.fillSuperview()
    }
    
    // MARK: Actions
    
    @IBAction func play() {
        let title = EKProperty.LabelContent(text: "Hi there!", style: EKProperty.LabelStyle(font: MainFont.bold.with(size: 16), color: .black))
        let description = EKProperty.LabelContent(text: "Are you ready for some testing?", style: EKProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .black))
        let image = EKProperty.ImageContent(image: UIImage(named: "ic_info_outline")!, size: CGSize(width: 30, height: 30))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        
        SwiftEntryKit.display(entry: contentView, using: attributesWrapper.attributes)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension PlaygroundViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func selectionCell(by id: String, and indexPath: IndexPath) -> SelectionBaseCell {
        return tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! SelectionBaseCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SelectionBaseCell
        cell = selectionCell(by: Cells.cells[indexPath.section][indexPath.row].className, and: indexPath)
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0...3):
            cell.configure(attributesWrapper: attributesWrapper)
        case (1, 0...2):
            cell.configure(attributesWrapper: attributesWrapper)
        case (1, 3):
            let cell = cell as! BackgroundStyleSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .screen)
        case (1, 4):
            let cell = cell as! BackgroundStyleSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .entry)
        case (2, 0):
            let cell = cell as! UserInteractionSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .screen)
        case (2, 1):
            let cell = cell as! UserInteractionSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .entry)
        case (2, 2...4):
            cell.configure(attributesWrapper: attributesWrapper)
        case (3, 0...3):
            cell.configure(attributesWrapper: attributesWrapper)
        case (4, 0):
            let cell = cell as! AnimationSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, action: .entrance)
        case (4, 1):
            let cell = cell as! AnimationSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, action: .exit)
        case (4, 2):
            let cell = cell as! AnimationSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, action: .pop)
        default:
            fatalError()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Cells.header.className) as! SelectionHeaderView
        header.text = Cells.sectionTitles[section]
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Cells.cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cells.cells[section].count
    }
    
    // iOS 9, 10 support
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
