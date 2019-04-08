//
//  CauseService.swift
//  Response
//
//  Created by Elmer Astudillo on 1/31/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum CauseType: String
{
    case organization = "organization"
    case mission = "mission"
    
    enum Path : String
    {
        case organizationCauses = "org_causes"
        case missionCauses = "mission_causes"
    }
}

struct CauseService
{
    static func fetchCause(forID id: String, completion: @escaping (Cause?) -> Void)
    {
        let ref = Database.database().reference().child("causes").child(id)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let cause = Cause(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(cause)
        })
    }
    
    // Fetch causes by path(.organizations, .missions)
    static func fetchCauses(forID id: String, causePath: CauseType.Path, completion: @escaping ([Cause?]) -> Void)
    {
        let ref = Database.database().reference().child(causePath.rawValue).child(id)
        var causeArray = [Cause]()
        ref.observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            for i in snapshot
            {
                let id = i.key
                CauseService.fetchCause(forID: id, completion: { (cause) in
                    guard let cause = cause else { return }
                    causeArray.append(cause)
                })
            }
            completion(causeArray)
        }
    }
    
    static func postCause(forID id:String, cause: Cause, causeType: CauseType)
    {
        let dictValue = cause.dictValue
        //TODO: Once needed add another node to update "causes"
        switch causeType {
        case .organization:
            let ref = Database.database().reference().child("org_causes").child(id).childByAutoId()
            ref.updateChildValues(dictValue) { (error, reference) in
                if (error != nil)
                {
                    print("Failure to insert")
                }
            }
        case .mission:
            let ref = Database.database().reference().child("mission_causes").child(id).childByAutoId()
            ref.updateChildValues(dictValue) { (error, reference) in
                if (error != nil)
                {
                    print("Failure to insert")
                }
            }
        }
    }
    
}

