//
//  Compound.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Compound {
    let persons: [Person]
    let dogs: [Dog]
    let cars: [Car]
    
    init?(json: JSON) {
        
        self.cars = json["cars"].arrayValue.flatMap { Car(json: $0) }
        
        self.dogs = json["dogs"].arrayValue.flatMap { Dog(json: $0) }
        
        self.persons = json["person"].arrayValue.flatMap { Person(json: $0) }
    }
}