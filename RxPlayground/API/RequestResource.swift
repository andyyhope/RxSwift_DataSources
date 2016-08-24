//
//  RequestResource.swift
//  PUFormKit
//
//  Created by Andyy Hope on 29/07/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import Foundation

public struct RequestResource {
    private let type: String = "json"
    
    public let filename: String
    
    public init(filename: String) {
        self.filename = filename
    }
    
    public var path: String {
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: type) {
            return path
        }
        else {
            assertionFailure("No file exists in the project named: \(filename)")
            return ""
        }
    }
}