//
//  story.swift
//  Response
//
//  Created by Elmer Astudillo on 1/12/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct StoryService
{
    //TODO: NEED TO UDATE
    static func fetchStory(forUID id: String, completion: @escaping (Story?) -> Void)
    {
        let ref = Database.database().reference().child("stories").child(id)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let story = Story(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(story)
        })
    }
    
}
