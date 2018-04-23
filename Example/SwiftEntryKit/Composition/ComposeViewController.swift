//
//  ComposeViewController.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ComposeViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let attributesWrapper = EntryAttributeWrapper(with: EKAttributes.default)
    
    struct Cells {
        static let position = String(describing: PositionSelectionTableViewCell.self)
        static let windowLevel = String(describing: WindowLevelTableViewCell.self)
        static let displayDuration = String(describing: DisplayDurationTableViewCell.self)
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
        tableView.register(PositionSelectionTableViewCell.self, forCellReuseIdentifier: Cells.position)
        tableView.register(WindowLevelTableViewCell.self, forCellReuseIdentifier: Cells.windowLevel)
        tableView.register(DisplayDurationTableViewCell.self, forCellReuseIdentifier: Cells.displayDuration)
        tableView.fillSuperview()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ComposeViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func selectionCell(by id: String, and indexPath: IndexPath) -> SelectionBaseCell {
        return tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! SelectionBaseCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectionBaseCell
        switch indexPath.row {
        case 0:
            cell = selectionCell(by: Cells.position, and: indexPath)
        case 1:
            cell = selectionCell(by: Cells.windowLevel, and: indexPath)
        case 2:
            cell = selectionCell(by: Cells.displayDuration, and: indexPath)
        default:
            fatalError()
        }
        cell.configure(attributesWrapper: attributesWrapper)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
