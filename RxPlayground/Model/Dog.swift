//
//  Dog.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Dog {
    let name: String
    let color: String
    
    init?(json: JSON) {
        guard let
            name = json["name"].string,
            color = json["color"].string
            else { return nil }
        
        self.name = name
        self.color = color
    }
}