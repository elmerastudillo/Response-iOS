//
//  story.swift
//  Response
//
//  Created by Elmer Astudillo on 1/12/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation

struct StoryService
{
    static func fetchStory(forUID uid: String, completion: @escaping (story?) -> Void)
    {
        let ref = Database.database().reference().child("stories").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let story = Story(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(organization)
        })
    }
}
