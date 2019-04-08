//
//  Response.swift
//  Response
//
//  Created by Elmer Astudillo on 1/18/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Response
{
    var id : String?
    var userID : String
    var amountDonated : Float
    var storyID : String
    var causeID : String
    var missionID: String
    var timestamp : Date
    
    init(userID: String, amountDonated: Float, storyID: String, causeID: String, missionID: String)
    {
        self.userID = userID
        self.amountDonated = amountDonated
        self.storyID = storyID
        self.causeID = causeID
        self.missionID = missionID
        self.timestamp = Date()
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String: Any],
            let userID = dict["userID"] as? String,
            let amountDonated = dict["amountDonated"] as? Float,
            let storyID = dict["storyID"] as? String,
            let causeID = dict["causeID"] as? String,
            let missionID = dict["missionID"] as? String,
            let timestamp = dict["timestamp"] as? Date
            else {return nil}
        self.id = snapshot.key
        self.userID = userID
        self.amountDonated = amountDonated
        self.storyID = storyID
        self.causeID = causeID
        self.missionID = missionID
        self.timestamp = timestamp
    }
    
    var dictValue: [String: Any]
    {
        let createdAgo = timestamp.timeIntervalSince1970
        
        return [ "userID" : userID,
                 "amountDonated" : amountDonated,
                 "storyID" : storyID,
                 "causeID" : causeID,
                 "missionID" : missionID,
                 "timestamp" : createdAgo
        ]
    }
}
