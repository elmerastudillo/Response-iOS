//
//  OrganizationProfileVC.swift
//  Response
//
//  Created by Keivan Shahida on 10/6/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import UIKit
import SnapKit

class OrganizationViewController: UITableViewController {

    var causes = [Cause]()
    var organization: Organization?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.backgroundColor = UIColor.responseBlack
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
        tableView.register(CauseCell.self, forCellReuseIdentifier: "causeTableViewCell")
        tableView.register(SecondaryHeaderView.self, forHeaderFooterViewReuseIdentifier: "secondaryHeaderView")

        self.causes = Cause.causes
    }
    
    //MARK: - CELLS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "causeTableViewCell") as! CauseCell
        
        switch indexPath.section {
        case 1:
            cell.causeDelegate = self
            cell.cause = causes[indexPath.row]
            cell.organization = Organization.organizations[0]
            return cell
        default:
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 195
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        let storiesVC = StoryViewController(collectionViewLayout: layout)
        storiesVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(storiesVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return causes.count
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = OrganizationHeaderView()
            header.containerView.image = UIImage(named: "refugees")
            header.organization = organization
            header.organizationProfileDelegate = self
            return header
        case 1:
            let header = SecondaryHeaderView(reuseIdentifier: "secondaryHeaderView")
            header.title = "Causes"
            return header
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 420.0
        case 1:
            return 60.0
        default:
            return 0
        }
    }
}

extension OrganizationViewController : OrganizationProfileDelegate {
    func follow() {
        
    }
    
    func donate(organization: Organization) {
        let responderViewController = RespondViewController()
        self.present(responderViewController, animated: true, completion: nil)
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func share() {
        
    }
}

extension OrganizationViewController : CauseDelegate {
    
    // MARK: - CauseDelegate Functions
    func respond(cause: Cause) {
        let responderViewController = RespondViewController()
        self.present(responderViewController, animated: true, completion: nil)
    }
    
    func viewCauseOrganization(organization: Organization) {
        print("Button was clicked")
        let organizationVC = OrganizationViewController()
        organizationVC.organization = organization
        present(organizationVC, animated: true, completion: nil)
        
    }
    
    func share(cause: Cause) {
        let shareVC = ShareViewController()
        present(shareVC, animated: true, completion: nil)
    }
}
