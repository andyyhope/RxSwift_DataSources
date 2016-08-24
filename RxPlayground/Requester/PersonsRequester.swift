//
//  Requester.swift
//  RxPlayground
//
//  Created by Andyy Hope on 24/08/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import Foundation
import SwiftyJSON

class Requester : Requestable, RequestTestable {
    
    // MARK: - Requests
    
    static func testCompound(delay delay: Int, completion: RequestResponse<Compound>.Completion) {
        
        test(.compound, log: true, delay: delay) {
            switch $0 {
            case .success(let response):
                parseCompound(response, completion: completion)
            case .fail:
                break
            }
        }
    }
    
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
    
    
    // MARK: - Parse
    
    private static func parseCompound(response: JSON, completion: RequestResponse<Compound>.Completion) {
        
        if let compound = Compound(json: response) {
            completion(response: .success(compound))
        }
        else {
            completion(response: .fail(.failedInitializer))
        }
    }
    
    private static func parsePersons(response: JSON, completion: RequestResponse<[Person]>.Completion) {
        let persons = response.arrayValue
            .flatMap { Person(json: $0) }
        
        completion(response: .success(persons))
    }
    
}