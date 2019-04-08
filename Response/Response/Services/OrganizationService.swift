//
//  OrganizationService.swift
//  Response
//
//  Created by Elmer Astudillo on 1/12/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct OrganizationService
{
    static func fetchOrganization(forID id: String, completion: @escaping (Organization?) -> Void)
    {
        let ref = Database.database().reference().child("organizations").child(id)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let organization = Organization(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(organization)
        })
    }
    
    static func fetchOrganizations(pageSize:UInt, lastPostKey: String? = nil, completion: @escaping ([Organization]) -> Void)
    {
        let ref = Database.database().reference().child("organizations")
        var query = ref.queryOrderedByKey().queryLimited(toLast: pageSize)
        // Query starting from lastPostKey
        if let lastPostKey = lastPostKey {
            query = query.queryEnding(atValue: lastPostKey)
        }
        query.observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            let organizations: [Organization] =
                snapshot
                    .reversed()
                    .flatMap {
                        guard let organization = Organization(snapshot: $0)
                            else { return nil }
                        return organization
            }
            completion(organizations)
        }
    }
    
    
}
