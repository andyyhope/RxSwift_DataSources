//
//  API.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import Foundation

enum API {
    case persons, compound
    
    var url : NSURL {
        switch self {
        case .persons, .compound:
            return NSURL()
        }
    }
    
    var resource: RequestResource {
        switch self {
        case .persons:
            return RequestResource(filename: "Persons")
        case .compound:
            return RequestResource(filename: "Compound")
        }
    }
}