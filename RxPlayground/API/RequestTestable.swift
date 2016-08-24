//
//  RequestTestable.swift
//  PUFormKit
//
//  Created by Andyy Hope on 26/07/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol RequestTestable : Requestable {
    static func test(resource: API, log: Bool, delay: Int, function: String, file: String, completion: RequestResponse<JSON>.Completion)
}

extension RequestTestable {
    
    static func test(api: API, log: Bool = false, delay: Int = 0, function: String = #function, file: String = #file, completion: RequestResponse<JSON>.Completion) {
        if log {
            dlog.file(file)
            dlog.fn(function)
            dlog.ln(api.resource.path.componentsSeparatedByString("/").last!)
        }
        
        do {
            let data = try NSData(contentsOfFile: api.resource.path, options: .DataReadingMappedIfSafe)
            parseRequest(data, response: nil, log: log, delay: delay, completion: completion)
        }
        catch let error as NSError {
            dlog.err(error)
            dlog.file(file)
            
            completion(response: .fail(.invalidData(error)))
        }
    }
    
    private static func parseRequest(data: NSData, response: NSURLResponse?, log: Bool, delay: Int, completion: RequestResponse<JSON>.Completion) {
        let seconds = Int64(UInt64(delay) * NSEC_PER_SEC)
        let delay = dispatch_time(DISPATCH_TIME_NOW, seconds)
        dispatch_after(delay, dispatch_get_main_queue()) {
            var error: NSError?
            let json = JSON(data: data, options: .MutableLeaves, error: &error)
            
            if let error = error {
                completion(response: .fail(.invalidData(error)))
            }
            else {
                completion(response: .success(json))
            }
        }
    }
}