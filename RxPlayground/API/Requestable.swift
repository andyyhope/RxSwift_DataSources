//
//  PURequester.swift
//  PUFormKit
//
//  Created by Andyy Hope on 25/07/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import Foundation
import SwiftyJSON

private let APIKey = "APIKey"

protocol Requestable {
    static func request(api: API, parameters: Parameters?, log: Bool, function: String, file: String, completion: RequestResponse<JSON>.Completion)
}

extension Requestable {
    
    typealias Parameters = [String : AnyObject]
    
    // MARK: - Requester
    
    static func request(api: API, parameters: Parameters? = nil, log: Bool = false, function: String = #function, file: String = #file, completion: RequestResponse<JSON>.Completion) {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: api.url)
        let params = parametersWithAPIKey(for: parameters)
        request.HTTPBody = httpBody(for: params)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTaskWithRequest(request) { (data, response, error) in
            
            if log {
                dlog.file(file)
                dlog.fn(function)
                dlog.url(api.url)
                dlog.body(parameters)
            }
            
            if let error = error {
                dlog.err(error)
                dlog.file(file)
                dlog.url(api.url)
                
                completion(response: .fail(.session(error)))
            }
            else if let data = data {
                self.parseRequest(data, response: response, log: log, completion: completion)
            }
        }
        .resume()
    }
    
    
    // MARK: - Parser
    
    private static func parseRequest(data: NSData, response: NSURLResponse?, log: Bool, completion: RequestResponse<JSON>.Completion) {
        
        var error: NSError?
        let json = JSON(data: data, options: .MutableLeaves, error: &error)
        
        dispatch_async(dispatch_get_main_queue()) {
            
            if let error = error {
                completion(response: .fail(.invalidData(error)))
            }
            else {
                if log { dlog.ln(json) }
                
                completion(response: .success(json))
            }
        }
    }
    
    
    // MARK: - Parameter Utilities
    
    private static func parametersWithAPIKey(for dictionary: Parameters?) -> [String: AnyObject] {
        var body = ["APIKey" : APIKey]
        
        guard let dictionary = dictionary else { return body }
        
        for (key, value) in dictionary {
            body[key] = String(value)
        }
        
        return body
    }
    
    private static func httpBody(for parameters: Parameters?) -> NSData? {
        guard let parameters = parameters else { return nil }
        
        do {
            let httpBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
            return httpBody
        }
        catch let error as NSError {
            dlog.err(error)
            assertionFailure()
            return nil
        }
        catch let data as NSData {
            return data
        }
    }
}