//
//  ResponseService.swift
//  Response
//
//  Created by Elmer Astudillo on 1/18/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum ResponsePath : String
{
    case userResponses = "user_responses"
    case causeResponses = "cause_responses"
}

struct ResponseService
{
    static func fetchResponse(forID id: String, completion: @escaping (Response?) -> Void)
    {
        let ref = Database.database().reference().child("responses").child(id)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let response = Response(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(response)
        })
    }
    
    // Fetch causes by path(.userResponses, .causeResponses)
    static func fetchResponses(forID id: String, responsePath: ResponsePath, completion: @escaping ([Response?]) -> Void)
    {
        let ref = Database.database().reference().child(responsePath.rawValue).child(id)
        var responseArray = [Response]()
        ref.observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            for i in snapshot
            {
                let id = i.key
                ResponseService.fetchResponse(forID: id, completion: { (cause) in
                    guard let cause = cause else { return }
                    responseArray.append(cause)
                })
            }
            completion(responseArray)
        }
    }
    
    static func postResponse(response: Response)
    {
        let userRef = Database.database().reference().child("user_responses").child(response.userID).childByAutoId()
        let causeRef = Database.database().reference().child("cause_responses").child(response.causeID).childByAutoId()
        let ref = Database.database().reference().child("responses").childByAutoId()
        let dictValue = response.dictValue
        
        userRef.updateChildValues(dictValue) { (error, reference) in
            if (error != nil)
            {
                print("Failure to insert")
            }
        }
        causeRef.updateChildValues(dictValue) { (error, reference) in
            if (error != nil)
            {
                print("Failure to insert")
            }
        }
        
        ref.updateChildValues(dictValue) { (error, reference) in
            if (error != nil)
            {
                print("Failure to insert")
            }
        }
        
    }
}
