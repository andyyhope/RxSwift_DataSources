//
//  PersonsRequester.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import Foundation
import SwiftyJSON

class PersonsRequester : Requestable, RequestTestable {
    
    static func testPersons(delay delay: Int, completion: RequestResponse<[Person]>.Completion) {
        test(.persons, log: true, delay: delay) {
            switch $0 {
            case .success(let response):
                parsePersons(response, completion: completion)
            case .fail:
                break
            }
        }
    }
    
    private static func parsePersons(response: JSON, completion: RequestResponse<[Person]>.Completion) {
        let persons = response.arrayValue
            .flatMap { Person(json: $0) }
        
        completion(response: .success(persons))
    }
    
}