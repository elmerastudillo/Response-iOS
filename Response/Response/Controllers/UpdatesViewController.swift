//
//  UpdatesViewController.swift
//  Response
//
//  Created by Elmer Astudillo on 2/1/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit

class UpdatesViewController : UITableViewController, UISearchBarDelegate, CauseDelegate
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(PrimaryHeaderView.self, forHeaderFooterViewReuseIdentifier: "primaryHeader")
        tableView.register(UpdatesHeaderView.self, forHeaderFooterViewReuseIdentifier: "updatesHeader")
        
        tableView.register(CauseCell.self, forCellReuseIdentifier: "causeCell")
        
        self.view.backgroundColor = UIColor.responseBlack
        let searchBar = SearchBar.createSearchBar()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    // MARK: - TABLEVIEW
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "causeCell") as! CauseCell
        cell.causeDelegate = self
        cell.organization = Organization.organizations[0]
        cell.cause = Cause.causes[0]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch (section){
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "primaryHeader") as! PrimaryHeaderView
            header.title = "Responses"
            return header
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "updatesHeader") as! UpdatesHeaderView
            return header
        default:
            return UITableViewHeaderFooterView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section){
        case 0:
            return 80
        case 1:
            return 30
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        let storyViewController = StoryViewController(collectionViewLayout: layout)
        storyViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        tabBarController?.present(storyViewController, animated: true, completion: nil)
    }
    
    // MARK: - CauseDelegate
    
    func respond(cause: Cause) {
        let responderViewController = RespondViewController()
        self.present(responderViewController, animated: true, completion: nil)
    }
    
    func viewCauseOrganization(organization: Organization) {
        let organizationViewController = OrganizationViewController()
        self.present(organizationViewController, animated: true, completion: nil)
    }
    
    func share(cause: Cause) {
        let shareVC = ShareViewController()
        present(shareVC, animated: true, completion: nil)
    }
}
