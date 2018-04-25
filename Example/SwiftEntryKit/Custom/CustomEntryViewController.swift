//
//  ComposeViewController.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEntryKit

class CustomEntryViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let attributesWrapper = EntryAttributeWrapper(with: EKAttributes())
    
    struct Cells {
        static let cells = [PositionSelectionTableViewCell.self,
                            WindowLevelTableViewCell.self,
                            DisplayDurationTableViewCell.self,
                            ShadowSelectionTableViewCell.self,
                            RoundCornersSelectionTableViewCell.self,
                            BackgroundStyleSelectionTableViewCell.self,
                            BackgroundStyleSelectionTableViewCell.self,
                            UserInteractionSelectionTableViewCell.self,
                            UserInteractionSelectionTableViewCell.self,
                            HapticFeedbackSelectionTableViewCell.self,
                            PopBehaviorSelectionTableViewCell.self,
                            ScrollSelectionTableViewCell.self,
                            SafeAreaSelectionTableViewCell.self,
                            WidthSelectionTableViewCell.self]
    }
    
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
        Cells.cells.forEach { tableView.register($0, forCellReuseIdentifier: $0.className) }
        tableView.fillSuperview()
        
        
    }
    
    @IBAction func play() {
        let title = EKProperty.LabelContent(text: "TEST!", style: EKProperty.Label(font: Font.HelveticaNeue.bold.with(size: 16), color: .black))
        let description = EKProperty.LabelContent(text: "Are you ready for some testing?", style: EKProperty.Label(font: Font.HelveticaNeue.light.with(size: 14), color: .black))
        let time = EKProperty.LabelContent(text: "12:00", style: EKProperty.Label(font: Font.HelveticaNeue.medium.with(size: 14), color: .black))
        let image = UIImage(named: "ic_info_outline")!
        let content = EKNotificationMessage(title: title, description: description, time: time, image: image)
        let contentView = EKNotificationMessageView(with: content)
        
        let containerView = EKContainerView()
        containerView.content = EKContainerView.Content(view: contentView, attributes: attributesWrapper.attributes)
        EKWindowProvider.shared.state = .message(view: containerView, attributes: attributesWrapper.attributes)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CustomEntryViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func selectionCell(by id: String, and indexPath: IndexPath) -> SelectionBaseCell {
        return tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! SelectionBaseCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SelectionBaseCell
        cell = selectionCell(by: Cells.cells[indexPath.row].className, and: indexPath)
        
        switch indexPath.row {
        case 0...4:
            cell.configure(attributesWrapper: attributesWrapper)
        case 5:
            let cell = cell as! BackgroundStyleSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .screen)
        case 6:
            let cell = cell as! BackgroundStyleSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .entry)
        case 7:
            let cell = cell as! UserInteractionSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .screen)
        case 8:
            let cell = cell as! UserInteractionSelectionTableViewCell
            cell.configure(attributesWrapper: attributesWrapper, focus: .entry)
        case 9, 10, 11, 12, 13:
            cell.configure(attributesWrapper: attributesWrapper)
        default:
            fatalError()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cells.cells.count
    }
}
