//
//  RequestError.swift
//  PUFormKit
//
//  Created by Andyy Hope on 29/07/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import Foundation

public enum RequestError : ErrorType {
    case failedInitializer
    case session(NSError)
    case invalidData(NSError)
    case punters(NSError)
    
    public func print() {
        switch self {
        case .failedInitializer:
            dlog.err("API: Failed Initializer")
            let error = NSError(
                    domain: "JSON",
                    code: 1,
                    userInfo: [
                        NSLocalizedDescriptionKey : "One of the keys required in a JSON initializer was missing"])
            dlog.err(error)
        
        case .session(let error):
            dlog.err("API: Session")
            dlog.err(error)
        
        case .invalidData(let error):
            dlog.err("API: Invalid Data")
            dlog.err(error)
        
        case .punters(let error):
            dlog.err("API: Punters")
            dlog.err(error)
        }
    }
}