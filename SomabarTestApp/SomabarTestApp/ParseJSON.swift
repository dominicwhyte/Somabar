//
//  ParseJSON.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 01/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import Foundation

class ParseJSON {
    
    static func getDictFromData(data : String) -> NSDictionary? {
        do {
            let jsonData: NSData? = data.dataUsingEncoding(NSUTF8StringEncoding)!
            let jsonDict : NSDictionary? = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments) as? NSDictionary
            return jsonDict
        }
        catch {
            print("error converting dict from data")
            return nil
        }
        
    }
    
    
}