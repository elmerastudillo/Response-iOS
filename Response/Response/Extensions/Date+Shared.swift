//
//  Date+Shared.swift
//  Response
//
//  Created by Elmer Astudillo on 2/23/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation

extension Date
{
    /**
     Return a string demonstrating time ago
     - Parameter meters: The dista
     - returns: Time ago in String format
    */
    func timeAgoDisplay() -> String
    {
        
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = minute * 60
        let day = 24 * hour
        let week = 7 * day
        
        
        if secondsAgo < minute {
            return "\(secondsAgo / hour) seconds ago"
        }
        else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        }
        else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        }
        else if secondsAgo < week {
            return "\(secondsAgo / hour) days ago"
        }
        
        return "\(secondsAgo / week) weeks ago"
    }
}
