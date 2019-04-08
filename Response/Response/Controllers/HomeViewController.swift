//
//  HomeViewController.swift
//  Response
//
//  Created by Elmer Astudillo on 2/15/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - INITIALIZATION
    var missions = [Mission]()
    var causes = [Cause]()
    var organizations = [Organization]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        causes = Cause.causes
        organizations = Organization.organizations
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.responseBlack
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets.zero
        tableView.sectionFooterHeight = 0
        self.definesPresentationContext = true
        
        tableView.register(MissionCell.self, forCellReuseIdentifier: "missionTableViewCell")
        tableView.register(CauseCell.self, forCellReuseIdentifier: "causeTableViewCell")
        tableView.register(OrganizationCell.self, forCellReuseIdentifier: "organizationCell")
        tableView.register(PrimaryHeaderView.self, forHeaderFooterViewReuseIdentifier: "primaryHeaderView")
        tableView.register(SecondaryHeaderView.self, forHeaderFooterViewReuseIdentifier:"secondaryHeaderView")
        
        let mission = Mission(name: "END HUNGER.", logoImageURL: "", thumbnailImageURL: "temp2", location: "MOGADISHU, SOMALIA", slogan: "", mission: "This is the current description of the mission", category:["Development" : true])
        missions.append(mission)
        
        let searchBar = SearchBar.createSearchBar()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        UIApplication.shared.isStatusBarHidden = false
    }
    
    //MARK: - TABLEVIEW
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "causeTableViewCell") as! CauseCell
        let orgCell = tableView.dequeueReusableCell(withIdentifier: "organizationCell") as! OrganizationCell
        
        var causeIndex = 0
        var orgIndex = 0
        
        switch indexPath.section
        {
        case 0:
            let missionCell = tableView.dequeueReusableCell(withIdentifier: "missionTableViewCell") as! MissionCell
            missionCell.missionDelegate = self
            missionCell.mission = missions[indexPath.row]
            missionCell.organization = Organization.organizations[indexPath.row]
            missionCell.dateStartedLabel.text = missionCell.mission?.date.timeAgoDisplay()
            return missionCell
        case 1:
            // TODO: Fix memory issue with multiple cause cell
            if indexPath.row % 3 != 0 || indexPath.row == 0 {
                causeIndex += 1
                cell.causeDelegate = self
                cell.organization = Organization.organizations[0]
                cell.cause = causes[causeIndex]
                return cell
            } else {
                orgIndex += 1
                orgCell.organizationDelegate = self
                orgCell.organization = organizations[orgIndex]
                return orgCell
            }
        default:
            return cell

        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section
        {
        case 0:
            return 470
        case 1:
            if indexPath.row % 3 != 0 || indexPath.row == 0 {
                return 195
            } else {
                return 240
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // handle row selection
        switch indexPath.section {
        case 0:
            let missionProfileViewController = MissionViewController()
//            missionProfileVC.hero.isEnabled = true
//            missionProfileVC.tableView.hero.id = "blue"
//            missionProfileVC.view.hero.modifiers = [.scale(0.5), .fade, .useGlobalCoordinateSpace]
            present(missionProfileViewController, animated: true, completion: nil)
        case 1:
             if indexPath.row % 3 != 0 || indexPath.row == 0 {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.minimumLineSpacing = 0.0
                layout.minimumInteritemSpacing = 0.0
                let storyViewController = StoryViewController(collectionViewLayout: layout)
                storyViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                tabBarController?.present(storyViewController, animated: true, completion: nil)
             }
            else {
//                let orgProfileVC = OrganizationViewController()
//
//
////                orgProfileVC.hero.isEnabled = true
////                orgProfileVC.tableView.hero.id = "blue"
////                orgProfileVC.view.hero.modifiers = [.scale(0.5), .fade, .useGlobalCoordinateSpace]
//                present(orgProfileVC, animated: true, completion: nil)
            }
        default:
            return
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            let count = causes.count + organizations.count
            return count
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
            let header = PrimaryHeaderView(reuseIdentifier: "primaryHeaderView")
            header.title = "Discover"
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
            return 70
        case 1:
            return 60
        default:
            return 60
        }
    }
}

// MARK: - SEARCHBAR DELEGATE
extension HomeViewController {
    // MARK: - SearchDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
    }
}

// MARK: - MISSION DELEGATE
extension HomeViewController: MissionDelegate {
    func share(mission : Mission) {
        let shareViewController = ShareViewController()
        shareViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        shareViewController.shareTitle = mission.name
        tabBarController?.present(shareViewController, animated: true, completion: nil)
        print("shared mission")
    }
    
    func viewMissionOrganization(organization: Organization) {
        print("Button was clicked")
        let organizationVC = OrganizationViewController()
        organizationVC.organization = organization
        present(organizationVC, animated: true, completion: nil)
    }
    
    func respond(mission: Mission) {
        let responderViewController = RespondViewController()
        self.present(responderViewController, animated: true, completion: nil)
    }
}

// MARK: - CAUSE DELEGATE
extension HomeViewController: CauseDelegate {

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
    
    func share(cause : Cause) {

    }
}

// MARK: - ORGANIZATION DELEGATE
extension HomeViewController: OrganizationDelegate {
    func respond(organization: Organization) {
        let responderViewController = RespondViewController()
        self.present(responderViewController, animated: true, completion: nil)
    }
    
    func viewFollowers() {
        
    }
    
    func responseButton(organization: Organization) { }
    
    func followersButton() { }
}

