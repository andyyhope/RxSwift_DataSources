//
//  RequestResponse.swift
//  PUFormKit
//
//  Created by Andyy Hope on 29/07/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import Foundation

public enum RequestResponse<T> {
    public typealias Completion = (response: RequestResponse<T>) -> Void
    
    case success(T)
    case fail(RequestError)
}
