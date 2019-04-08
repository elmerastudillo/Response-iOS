//
//  SettingsViewController.swift
//  Response
//
//  Created by Keivan Shahida on 4/8/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

struct SettingsSection { //TEMP FOR TESTING
    
    var sectionTitle: String!
    var sectionItems: [String]
    
    init(title: String, items: [String]) {
        self.sectionTitle = title
        self.sectionItems = items
    }
}

class SettingsViewController: UITableViewController {
    
    var sections = [SettingsSection(title: "Billing", items: ["View Transactions", "Manage Preferences"]), SettingsSection(title: "Notifications", items: ["Manage Preferences"]) ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(SettingsHeaderView.self, forHeaderFooterViewReuseIdentifier: "settingsHeaderView")
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "settingsCell")
        
        self.view.backgroundColor = UIColor.responseBlack
    }
    
    // MARK: - SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "settingsHeaderView") as! SettingsHeaderView
        header.title = sections[section].sectionTitle.uppercased()
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // MARK: - CELLS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].sectionItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsCell
        cell.title = sections[indexPath.section].sectionItems[indexPath.row]
        return cell
    }
}
