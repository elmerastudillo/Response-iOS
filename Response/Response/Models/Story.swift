//
//  Story.swift
//  Response
//
//  Created by Elmer Astudillo on 1/12/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

struct Story
{
    var title: String
    var date: Date
    var subtitle: String
    var location: String
    var latitude: Float
    var longitude: Float
    var storyImage: String
    var storyVideo: String
    var organizationID: String
//    var topics: [String]
    var responses: Int
    var amountCollected: Float
    var avgDonation: Float
    var uniqueDonors : Float
    
    init(title: String, subtitle: String, location: String, latitude: Float, longititude: Float, storyImage: String, storyVideo: String, organizationID: String, responses: Int, amountCollected: Float, avgDonation: Float, uniqueDonors: Float)
    {
        self.title = title
        self.date = Date()
        self.subtitle = subtitle
        self.location = location
        self.latitude = latitude
        self.longitude = longititude
        self.storyImage = storyImage
        self.storyVideo = storyVideo
        self.organizationID = organizationID
        self.responses = responses
        self.amountCollected = amountCollected
        self.avgDonation = avgDonation
        self.uniqueDonors = uniqueDonors
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String : Any],
            let title = dict["title"] as? String,
            let date = dict["date"] as? Date,
            let subtitle = dict["subtitle"] as? String,
            let location = dict["location"] as? String,
            let latitude = dict["latitude"] as? Float,
            let longitude = dict["longitude"] as? Float,
            let storyImage = dict["storyImage"] as? String,
            let storyVideo = dict["storyVideo"] as? String,
            let organizationID = dict["organiorganizationID"] as? String,
            let responses = dict["reponses"] as? Int,
            let amountCollected = dict["amountamountCollected"] as? Float,
            let avgDonation = dict["avgDonation"] as? Float,
            let uniqueDonors = dict["uniqueDonors"] as? Float
            else { return nil }
        self.title = title
        self.date = date
        self.subtitle = subtitle
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.storyImage = storyImage
        self.storyVideo = storyVideo
        self.organizationID = organizationID
        self.responses = responses
        self.amountCollected = amountCollected
        self.avgDonation = avgDonation
        self.uniqueDonors = uniqueDonors
    }
}
