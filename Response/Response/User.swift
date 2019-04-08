//
//  User.swift
//  Response
//
//  Created by Keivan Shahida on 10/23/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class User {

    var id: String
    var first_name: String
    var last_name: String
    var name: String
    var email: String
    // FACEBOOK only returns age range
    var age : Int?
    let gender: String
    var responseCount: Int
    var causeCount: Int
    var savedCount: Int
    var deviceModel: String
    
    init(id: String, first_name: String, last_name: String, name: String, email: String, gender: String){
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.name = name
        self.email = email
        self.gender = gender
        self.responseCount = 0 //temp
        self.causeCount = 0 //temp
        self.savedCount = 0 // temp
        self.deviceModel = UIDevice.current.model
    }
    
    init(id: JSON, first_name: JSON, last_name: JSON, name: JSON, email: JSON, age: JSON, gender:JSON, deviceModel: JSON ){
        self.id = id.stringValue
        self.first_name = first_name.stringValue
        self.last_name = last_name.stringValue
        self.name = name.stringValue
        self.email = email.stringValue
        self.age = age.intValue
        self.gender = gender.stringValue
        self.deviceModel = deviceModel.stringValue
        self.responseCount = 0 //temp
        self.causeCount = 0 //temp
        self.savedCount = 0 // temp
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String: Any],
            let first_name = dict["first_name"] as? String,
            let last_name = dict["last_name"] as? String,
            let name = dict["name"] as? String,
            let email = dict["email"] as? String,
            let age = dict["age"] as? Int,
            let gender = dict["gender"] as? String,
            let deviceModel = dict["deviceModel"] as? String,
            let responseCount = dict["responseCount"] as? Int,
            let causeCount =  dict["causeCount"] as? Int,
            let savedCount = dict["savedCount"] as? Int
            else { return nil }
        self.id = snapshot.key
        self.first_name = first_name
        self.last_name = last_name
        self.name = name
        self.email = email
        self.age = age
        self.gender = gender
        self.deviceModel = deviceModel
        self.responseCount = responseCount
        self.causeCount = causeCount
        self.savedCount = savedCount
    }
    
    //UserDefaults
    required init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: "id") as? String,
            let first_name = aDecoder.decodeObject(forKey: "first_name") as? String,
            let last_name = aDecoder.decodeObject(forKey: "last_name") as? String,
            let name = aDecoder.decodeObject(forKey: "name") as? String,
            let email = aDecoder.decodeObject(forKey: "email") as? String,
            let age = aDecoder.decodeObject(forKey: "age") as? Int,
            let gender = aDecoder.decodeObject(forKey: "gender") as? String,
            let deviceModel = aDecoder.decodeObject(forKey: "deviceModel") as? String,
            let responseCount = aDecoder.decodeObject(forKey: "responseCount") as? Int,
            let causeCount = aDecoder.decodeObject(forKey: "causeCount") as? Int,
            let savedCount = aDecoder.decodeObject(forKey: "savedCount") as? Int
            else { return nil }
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.name = name
        self.email = email
        self.age = age
        self.gender = gender
        self.deviceModel = deviceModel
        self.responseCount = responseCount
        self.causeCount = causeCount
        self.savedCount = savedCount
    }
    
    static var currentUser: User?
    
    // Function to update current user properties and save them to User Defaults
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            UserDefaults.standard.set(data, forKey: "currentUser")
        }
        currentUser = user
    }
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(first_name, forKey: "first_name")
        aCoder.encode(last_name, forKey: "last_name")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(deviceModel, forKey: "deviceModel")
        aCoder.encode(responseCount, forKey: "responseCount")
        aCoder.encode(causeCount, forKey: "causeCount")
        aCoder.encode(savedCount, forKey: "savedCount")
    }
}

