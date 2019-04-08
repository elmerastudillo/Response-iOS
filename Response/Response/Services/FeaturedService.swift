//
//  FeaturedService.swift
//  Response
//
//  Created by Elmer Astudillo on 2/9/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FeaturedService
{
    static func fetchFeaturedContent(completion:@escaping([Cause], [Mission], [Organization]) -> Void )
    {
        let ref = Database.database().reference().child("featured_live")
        var causeArray = [Cause]()
        var missionArray = [Mission]()
        var organizationArray = [Organization]()
        
        ref.observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else {return completion([],[],[])}
            let featured: [Featured] =
                snapshot
                    .reversed()
                    .flatMap {
                        guard let cause = Featured(snapshot: $0)
                            else { return nil }
                        return cause
            }
            for i in featured
            {
                switch i.type
                {
                case .cause:
                    CauseService.fetchCause(forID: i.id, completion: { (cause) in
                        guard let cause = cause else { return }
                        causeArray.append(cause)
                    })
                case .mission:
                    MissionService.fetchMission(forID: i.id, completion: { (mission) in
                        guard let mission = mission else { return }
                        missionArray.append(mission)
                    })
                case .organization:
                    OrganizationService.fetchOrganization(forID: i.id, completion: { (organization) in
                        guard let organization = organization else { return }
                        organizationArray.append(organization)
                    })
                }
            }
            
        }
        completion(causeArray, missionArray, organizationArray)
    }
}

