//
//  Cause.swift
//  Response
//
//  Created by Keivan Shahida on 8/12/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Cause {
    var id: String?
    var title: String
    var image: UIImage?
//    var image: String
    var location: String
    var shortDescription: String
    var description: String
    var responses: Int
    var charityShortname: String
    var dateStarted : Date
    var category: [String : Bool]
    var isFeatured = false
    
    init(title: String, image: UIImage, location: String, shortDescription: String, description: String, responses: Int, charityShortname: String, category: [String : Bool]) {
        
        self.title = title
        self.image = image
        self.location = location
        self.shortDescription = shortDescription
        self.description = description
        self.responses = responses
        self.charityShortname = charityShortname
        self.dateStarted = Date()
        self.category = category
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String: Any],
            let title = dict["title"] as? String,
//            let image = dict["image"] as? String,
            let location = dict["location"] as? String,
            let shortDescription = dict["shortDescription"] as? String,
            let description = dict["description"] as? String,
            let responses = dict["responses"] as? Int,
            let charityShortname = dict["charityShortName"] as? String,
            let dateStarted = dict["dateStarted"] as? Date,
            let category = dict["category"] as? [String: Bool]
            else {return nil}
        self.id = snapshot.key
        self.title = title
        // TODO: Connect with Firebase Storage
//        self.image = image
        self.location = location
        self.shortDescription = shortDescription
        self.description = description
        self.responses = responses
        self.charityShortname = charityShortname
        self.dateStarted = dateStarted
        self.category = category
    }
    
    func responsesFormatter() -> String {
        let formattedResponses = Double(responses)
        
        if (formattedResponses < 1000) {
            return "\(Int(formattedResponses))"
        } else if (formattedResponses < 1000000){
            return "\(Int(formattedResponses / 1000))K"
        } else {
            return ""
        }
    }
    
    var dictValue: [String: Any]
    {
        let createdAgo = dateStarted.timeIntervalSince1970
        
        return [ "title" : title,
                 "image" : image ?? "Empty",
                 "location" : location,
                 "shortDescription" : shortDescription,
                 "description" : description,
                 "responses" : responses,
                 "charityShortname" : charityShortname,
                 "dateStarted" : createdAgo,
                 "category" : category
        ]
    }
    
    // TEMP FOR TESTING
    static var causes = [
        Cause(title: "Talia Radofa", image: #imageLiteral(resourceName: "temp2"), location: "Leer County, South Sudan", shortDescription: "Drought strikes again", description: "Intense drought has ravaged a city in need of desperate care", responses: 19100, charityShortname: "U", category: ["Development" : true]),
        Cause(title: "Refugee Crisis", image: #imageLiteral(resourceName: "temporary"), location: "Aleppo, Syria", shortDescription: "Crisis across the country", description: "Syrian civilians devastated by the unruly grasp of Assad.", responses: 900000, charityShortname: "DWB",category: ["Development": true]),
        Cause(title: "Earthquake", image: #imageLiteral(resourceName: "temp2"), location: "Ghorka, Nepal", shortDescription: "A nation shaken up.", description: "Another earthquake demolishes cities around Nepal", responses: 100, charityShortname: "RC", category: ["Development": true]),
        Cause(title: "Famine", image: #imageLiteral(resourceName: "temp3"), location: "Leer County, South Sudan", shortDescription: "Drought strikes again", description: "Intense drought has ravaged a city in need of desperate care", responses: 19100, charityShortname: "U", category: ["Development": true])
    ]
}
