//
//  ResponsesViewController.swift
//  Response
//
//  Created by Elmer Astudillo on 2/1/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UITableViewController, UISearchBarDelegate, ProfileFooterDelegate, CollapsibleHeaderViewDelegate {
    var didAnimate: Bool = false
    
    var expanded = false
    var payments = [9.99, 1.99, 3.99]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PrimaryHeaderView.self, forHeaderFooterViewReuseIdentifier: "primaryHeaderView")
        tableView.register(ProfilePaymentHeaderView.self, forHeaderFooterViewReuseIdentifier: "paymentHeaderView")
        tableView.register(ProfileFooterView.self, forHeaderFooterViewReuseIdentifier: "footerView")
        
        tableView.register(ProfileProgressCell.self, forCellReuseIdentifier: "progressCell")
        tableView.register(ProfileDescriptionCell.self, forCellReuseIdentifier: "descriptionCell")
        tableView.register(ProfilePaymentCell.self, forCellReuseIdentifier: "paymentCell")
        
        self.view.backgroundColor = UIColor.responseBlack
        let searchBar = SearchBar.createSearchBar()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    //MARK: - TABLEVIEW
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell") as! ProfileProgressCell
                cell.didAnimate = didAnimate
                didAnimate = false
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! ProfileDescriptionCell
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            if expanded {
                let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell") as! ProfilePaymentCell
                cell.amount = payments[indexPath.row]
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
            case 0:
                return CGFloat(260)
            case 1:
                return CGFloat(80)
            default:
                return CGFloat(0)
            }
        case 1:
            if expanded {
                return CGFloat(80)
            } else {
                return CGFloat(0)
            }
        default:
            return CGFloat(0)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 2
        case 1:
            return payments.count
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch (section){
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "primaryHeaderView") as! PrimaryHeaderView
            header.title = "Profile"
            return header
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "paymentHeaderView") as! ProfilePaymentHeaderView
            header.customInit(section: section, delegate: self)
            return header
        case 2:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footerView") as! ProfileFooterView
            header.profileFooterDelegate = self
            return header
        default:
            return UITableViewHeaderFooterView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section){
        case 0:
            return CGFloat(60.0)
        case 1:
            return CGFloat(60.0)
        case 2:
            return CGFloat(120.0)
        default:
            return CGFloat(0)
        }
    }
    
    // MARK: - BUTTONS
    func viewSettings() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
        print("settings")
    }
    
    func viewPastTransactions() {
        print("transactions")
    }
    
    // MARK: - COLLAPSIBLE HEADER
    
    func toggleSection(header: ProfilePaymentHeaderView, section: Int) {
        expanded = !expanded
        UIView.performWithoutAnimation {
            tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
        }
    }
}

