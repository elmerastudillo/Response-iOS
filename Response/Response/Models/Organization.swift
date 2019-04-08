//
//  Organization.swift
//  Response
//
//  Created by Elmer Astudillo on 1/12/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Organization {
    var id: String?
    var name: String
    var orgCode: String
    var logoImageURL: String
    var thumbnailImageURL: String
    var location: String
    var videoURL : String?
    // TODO: Implement Stories
//    var stories: [String]
    var mission: String
    var slogan: String
    var color: UIColor?
    var followers: Int
    
    init(name: String, orgCode: String, logoImageURL: String, thumbnailImageURL: String , videoURL: String, location: String, slogan: String, mission: String, color: UIColor) {
        self.name = name
        self.orgCode = orgCode
        self.logoImageURL = logoImageURL
        self.thumbnailImageURL = thumbnailImageURL
        self.videoURL = videoURL
        self.location = location
        self.slogan = slogan
        self.mission = mission
        self.color = color
        self.followers = 0
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String: Any],
            let name = dict["name"] as? String,
            let orgCode = dict["orgCode"] as? String,
            let logoImageURL = dict["logoImageURL"] as? String,
            let thumbnailImageURL = dict["thumbnailImageURL"] as? String,
            let videoURL = dict["videoURL"] as? String,
            let location = dict["location"] as? String,
            let slogan = dict["slogan"] as? String,
            let mission = dict["mission"] as? String,
            let followers = dict["followers"] as? Int
//          let color = dict["color"] as? String
            else { return nil }
        self.id = snapshot.key
        self.name = name
        self.orgCode = orgCode
        self.logoImageURL = logoImageURL
        self.thumbnailImageURL = thumbnailImageURL
        self.location = location
        self.slogan = slogan
        self.mission = mission
        self.followers = followers
        self.videoURL = videoURL
//        self.color = color
    }
    
    
    //TEMP FOR TESTING
    
//    static let unicef = Organization(name: "UNICEF", shortname: "U", image: #imageLiteral(resourceName: "unicefulllogo"), thumbnail: #imageLiteral(resourceName: "uniceflogo"), location: "New York, USA", shortDescription: "Helping the children.", description: "helping eat kale brown banana orange apple bus Drake mac people president", color: .responseBlue)
    static var organizations = [
    Organization(name: "Unicef", orgCode: "U", logoImageURL: "unicefLogo-1", thumbnailImageURL: "unicef-children", videoURL: "No video", location: "New York, USA", slogan: "Helping the children.", mission: "helping eat kale brown banana orange apple bus Drake mac people president", color: .responseBlue),
    
     Organization(name: "Unicef", orgCode: "U", logoImageURL: "unicefLogo-1", thumbnailImageURL: "unicef-children", videoURL: "No video", location: "New York, USA", slogan: "Helping the children.", mission: "helping eat kale brown banana orange apple bus Drake mac people president", color: .responseBlue),
    
     Organization(name: "Unicef", orgCode: "U", logoImageURL: "unicefLogo-1", thumbnailImageURL: "unicef-children", videoURL: "No video", location: "New York, USA", slogan: "Helping the children.", mission: "helping eat kale brown banana orange apple bus Drake mac people president", color: .responseBlue),
    
     Organization(name: "Unicef", orgCode: "U", logoImageURL: "unicefLogo-1", thumbnailImageURL: "unicef-children", videoURL: "No video", location: "New York, USA", slogan: "Helping the children.", mission: "helping eat kale brown banana orange apple bus Drake mac people president", color: .responseBlue),
    
     Organization(name: "Unicef", orgCode: "U", logoImageURL: "unicefLogo-1", thumbnailImageURL: "unicef-children", videoURL: "No video", location: "New York, USA", slogan: "Helping the children.", mission: "helping eat kale brown banana orange apple bus Drake mac people president", color: .responseBlue)
    ]
    
}
