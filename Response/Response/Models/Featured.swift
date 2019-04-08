//
//  Featured.swift
//  Response
//
//  Created by Elmer Astudillo on 2/10/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

enum FeaturedType : String
{
    case mission = "mission"
    case organization = "Organization"
    case cause = "Cause"
}

class Featured
{
    let id : String
    let date: Date
    let type: FeaturedType
    let isLive: Bool
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String: Any],
            let date = dict["date"] as? Date,
            let type = dict["type"] as? FeaturedType,
            let isLive = dict["isLive"] as? Bool
            else { return nil }
        self.id = snapshot.key
        self.date = date
        self.type = type
        self.isLive = isLive
    }
}
