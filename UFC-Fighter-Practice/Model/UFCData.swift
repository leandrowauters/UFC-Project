//
//  UFCData.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/19/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

struct UFCData {
    static var favoriteFighterId = [Int]()
    static func saveIdToArray(fighterId: String) {
        let defaults = UserDefaults.standard
        defaults.set(favoriteFighterId, forKey: fighterId)
    }
    static func retrieveArray(fighterId: String) ->[Int] {
        let defaults = UserDefaults.standard
        let array = defaults.array(forKey: fighterId)  as? [Int] ?? [Int]()
        return array
    }
    static func printAllDefaults(){
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
    }
    static func delete(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
    
    
    
}
