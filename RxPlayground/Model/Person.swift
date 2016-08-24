//
//  Person.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Person {
    let name: String
    let age: Int
    
    init?(json: JSON) {
        guard let
            name = json["name"].string,
            age = json["age"].int
            else { return nil }
        
        self.name = name
        self.age = age
    }
}
