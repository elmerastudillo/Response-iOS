//
//  MissionProfileVC.swift
//  Response
//
//  Created by Elmer Astudillo on 2/16/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit
import SnapKit

class MissionViewController: UITableViewController {

    // MARK: - INITIALIZATION
    var causes = [Cause]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        tableView = UITableView(frame: .zero, style: .grouped)
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
        tableView.register(PartnersCell.self, forCellReuseIdentifier: "partnersTableViewCell")
        tableView.register(SecondaryHeaderView.self, forHeaderFooterViewReuseIdentifier: "secondaryHeaderView")
        
        self.causes = Cause.causes
        

    }

    //MARK: - TABLEVIEW
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "causeTableViewCell") as! CauseCell

        switch indexPath.section {
        case 1:
             let partnersCell = tableView.dequeueReusableCell(withIdentifier: "partnersTableViewCell") as! PartnersCell
            return partnersCell
        case 2:
            cell.cause = causes[indexPath.row]
            cell.organization = Organization.organizations[0]
            cell.causeDelegate = self
            return cell
        default:
            return cell
        }
    }
        
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 100
        case 2:
            return 195
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // handle row selection
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
            return 1
        case 2:
            return causes.count
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = MissionHeaderView()
            header.containerView.frame = CGRect(x: 0, y: 0, width: 0, height: 420)
            header.missionProfileDelegate = self
            header.containerView.image = UIImage(named: "refugees")
            return header
        case 1:
            let header = SecondaryHeaderView(reuseIdentifier: "secondaryHeaderView")
            header.title = "Partners"
            return header
        case 2:
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
        case 2:
            return 60.0
        default:
            return 0
        }
    }
}

// MARK: - MISSION PROFILE DELEGATE
extension MissionViewController : MissionProfileDelegate {
    func follow() {
        
    }
    
    func donate(mission: Mission) {
        let responderViewController = RespondViewController()
        self.present(responderViewController, animated: true, completion: nil)
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func share() {
        let shareVC = ShareViewController()
        present(shareVC, animated: true, completion: nil)
    }
}

// MARK: - CAUSE DELEGATE
extension MissionViewController : CauseDelegate {
    func viewCauseOrganization(organization: Organization) {
        print("Button was clicked")
        let organizationVC = OrganizationViewController()
        organizationVC.organization = organization
        present(organizationVC, animated: true, completion: nil)
    }
    
    
    // MARK: - CauseDelegate Functions
    func respond(cause: Cause) {
        let responderViewController = RespondViewController()
        self.present(responderViewController, animated: true, completion: nil)
    }
    
    func share(cause : Cause) {
        let shareVC = ShareViewController()
        present(shareVC, animated: true, completion: nil)
    }
}
