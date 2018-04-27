//
//  ComposeViewController.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEntryKit

class PlaygroundViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let attributesWrapper = EntryAttributeWrapper(with: EKAttributes())
    
    struct Cells {
        
        static let sectionTitles = ["Display", "Interaction", "Size & Position", "Animation"]
        
        static let header = SelectionHeaderView.self
        
        static let cells = [[PositionSelectionTableViewCell.self,
                            WindowLevelTableViewCell.self,
                            DisplayDurationTableViewCell.self,
                            ShadowSelectionTableViewCell.self,
                            RoundCornersSelectionTableViewCell.self,
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
        let title = EKProperty.LabelContent(text: "TEST!", style: EKProperty.Label(font: Font.HelveticaNeue.bold.with(size: 16), color: .black))
        let description = EKProperty.LabelContent(text: "Are you ready for some testing?", style: EKProperty.Label(font: Font.HelveticaNeue.light.with(size: 14), color: .black))
        let time = EKProperty.LabelContent(text: "12:00", style: EKProperty.Label(font: Font.HelveticaNeue.medium.with(size: 14), color: .black))
        let image = UIImage(named: "ic_info_outline")!
        let content = EKNotificationMessage(title: title, description: description, time: time, image: image, roundImage: false)
        let contentView = EKNotificationMessageView(with: content)
        
        EKWindowProvider.shared.state = .message(view: contentView, attributes: attributesWrapper.attributes)
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
        case (0, 0...4):
            cell.configure(attributesWrapper: attributesWrapper)
        case (0, 5):
            let cell = cell as! BackgroundStyleSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .screen)
        case (0, 6):
            let cell = cell as! BackgroundStyleSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .entry)
        case (1, 0):
            let cell = cell as! UserInteractionSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .screen)
        case (1, 1):
            let cell = cell as! UserInteractionSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .entry)
        case (1, 2...4):
            cell.configure(attributesWrapper: attributesWrapper)
        case (2, 0...3):
            cell.configure(attributesWrapper: attributesWrapper)
        case (3, 0):
            let cell = cell as! AnimationSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, action: .entrance)
        case (3, 1):
            let cell = cell as! AnimationSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, action: .exit)
        case (3, 2):
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Cells.sectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Cells.cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cells.cells[section].count
    }
}
