//
//  Dlog.swift
//  PUFormKit
//
//  Created by Andyy Hope on 25/07/2016.
//  Copyright © 2016 Punters. All rights reserved.
//

import Foundation
public class dlog {
    
    private class var production : Bool {
        return false
    }
    
    public static func file(file: String) {
        let filename = file.componentsSeparatedByString("/").last
        log("🔍\t\(filename ?? "[Unknown file]")")
    }
    
    public static func fn(function: String) {
        log("📍\t\(function)")
    }
    
    public static func ln<T>(object: T) {
        log("🔸\t\(object)")
    }
    
    public static func err(type: String) {
        log("\n⚠️\t\(type)")
    }
    
    public static func err(error: NSError?) {
        guard let error = error else { return }
        
        log("\n⚠️\t\(error.description)\n")
    }
    
    public static func url(url: NSURL?) {
        guard let url = url else { return }
        
        log("🌏\t\(url)")
    }
    
    public static func body(body: [String: AnyObject]?) {
        guard let body = body else { return }
        
        log("📤\t\(body)")
    }
    
    public static func body(body: String?) {
        guard let body = body else { return }
        
        log("📤\t\(body)")
    }
    
    private static func log<T>(statement: T) {
        guard !dlog.production else { return }
        
        print(statement)
    }
}