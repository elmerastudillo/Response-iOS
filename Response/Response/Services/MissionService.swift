//
//  MissionService.swift
//  Response
//
//  Created by Elmer Astudillo on 1/31/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct MissionService
{
    static func fetchMission(forID id: String, completion: @escaping (Mission?) -> Void)
    {
        let ref = Database.database().reference().child("missions").child(id)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let mission = Mission(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(mission)
        })
    }
    
    static func fetchMissions(pageSize:UInt, lastPostKey: String? = nil, completion: @escaping ([Mission]) -> Void)
    {
        let ref = Database.database().reference().child("missions")
        var query = ref.queryOrderedByKey().queryLimited(toLast: pageSize)
        // Query starting from lastPostKey
        if let lastPostKey = lastPostKey {
            query = query.queryEnding(atValue: lastPostKey)
        }
        query.observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            let missions: [Mission] =
                snapshot
                    .reversed()
                    .flatMap {
                        guard let mission = Mission(snapshot: $0)
                            else { return nil }
                        return mission
            }
            completion(missions)
        }
    }
}
