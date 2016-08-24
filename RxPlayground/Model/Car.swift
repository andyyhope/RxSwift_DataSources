//
//  Cat.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Car {
    let make: String
    let model: String
    
    init?(json: JSON) {
        guard let
            make = json["make"].string,
            model = json["model"].string
            else { return nil }
        
        self.make = make
        self.model = model
    }
}