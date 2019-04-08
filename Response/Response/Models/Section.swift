//
//  Section.swift
//  Response
//
//  Created by Elmer Astudillo on 4/16/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation


struct Section {
    let name: String
    let array: [Any]
    let expanded : Bool
    
    init(name: String, array: [Any], expanded: Bool) {
        self.name = name
        self.array = array
        self.expanded = expanded
    }
}
