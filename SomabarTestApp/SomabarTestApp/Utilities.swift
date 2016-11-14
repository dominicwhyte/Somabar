//
//  Utilities.swift
//  SomabarTestApp
//
//  Created by Dominic Whyte on 02/09/16.
//  Copyright © 2016 relayr. All rights reserved.
//

import Foundation

class Utilities {
    
    //returns true iff string is made up of 1-31 numbers, letters, or underscores
    static func checkIfValidInput(input : String) -> Bool {
        if (input.characters.count < 1 || input.characters.count > 31) {
            print("input string of wrong length")
            return false
        }
        
        let goodCharacters = NSMutableCharacterSet() //create an empty mutable set
        goodCharacters.formUnionWithCharacterSet(NSCharacterSet.decimalDigitCharacterSet())
        goodCharacters.formUnionWithCharacterSet(NSCharacterSet.alphanumericCharacterSet())
        goodCharacters.formUnionWithCharacterSet(NSCharacterSet.capitalizedLetterCharacterSet())
        goodCharacters.addCharactersInString("_")
        let badCharacters = goodCharacters.invertedSet
        
        if input.rangeOfCharacterFromSet(badCharacters) == nil {
            return true
        } else {
            return false
        }
    }
    
    static func splitTopicBySlashes(topic : String) -> [String] {
        return topic.componentsSeparatedByString("/")
    }
}