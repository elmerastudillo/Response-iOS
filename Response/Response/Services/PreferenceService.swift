//
//  TagService.swift
//  Response
//
//  Created by Elmer Astudillo on 2/9/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase


struct PreferenceService
{
    static func fetchCauseByPreference(forPreference preference:String, completion: @escaping([Cause]) -> Void)
    {
        let ref = Database.database().reference().child("cause_preferences").child(preference)
        ref.observe(.value) { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            let causes: [Cause] =
                snapshot
                    .reversed()
                    .flatMap {
                        guard let cause = Cause(snapshot: $0)
                            else { return nil }
                        return cause
            }
            completion(causes)
        }
    }

    static func addPrefToUser(forPreference preferences:[String:Bool], forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        guard let currentUID = User.currentUser?.id else { return }
        let ref = Database.database().reference().child("users").child(currentUID).child("preferences")
        ref.updateChildValues(preferences) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            success(error == nil)
        }
    }
}
