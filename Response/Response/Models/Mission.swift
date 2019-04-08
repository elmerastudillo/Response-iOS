//
//  Mission.swift
//  Response
//
//  Created by Elmer Astudillo on 1/31/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Mission
{
    var id: String?
    var name: String
    var logoImageURL: String
    var thumbnailImageURL: String
    var videoURL : String?
    var location: String
    var date: Date
    // TODO: Implement Stories
    //    var stories: [String]
    var mission: String
    var slogan: String
    var followers: Int
    var responses: Int
    var category: [String : Bool]
    
    init(name: String, logoImageURL: String, thumbnailImageURL: String, location: String, slogan: String, mission: String, category: [String: Bool]) {
        self.name = name
        self.logoImageURL = logoImageURL
        self.thumbnailImageURL = thumbnailImageURL
        self.location = location
        self.slogan = slogan
        self.mission = mission
        self.followers = 0
        self.date = Date()
        self.category = category
        self.responses = 0
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String: Any],
            let name = dict["name"] as? String,
            let logoImageURL = dict["logoImageURL"] as? String,
            let thumbnailImageURL = dict["thumbnailImageURL"] as? String,
            let videoURL = dict["videoURL"] as? String,
            let location = dict["location"] as? String,
            let slogan = dict["slogan"] as? String,
            let mission = dict["mission"] as? String,
            let followers = dict["followers"] as? Int,
            let category = dict["category"] as? [String: Bool],
            let date = dict["dateStarted"] as? Date,
            let responses = dict["responses"] as? Int
            else { return nil }
        self.id = snapshot.key
        self.name = name
        self.logoImageURL = logoImageURL
        self.thumbnailImageURL = thumbnailImageURL
        self.videoURL = videoURL
        self.location = location
        self.slogan = slogan
        self.mission = mission
        self.followers = followers
        self.category = category
        self.date = date
        self.responses = responses
    }
}
