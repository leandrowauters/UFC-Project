//
//  UFCData.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/19/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

struct FavoriteFighterClient {
    static var favoriteFighterId = [Int]()
    static var everyFighter = [UFCFighter]()
    static func saveIdToArray() {
        let defaults = UserDefaults.standard
        defaults.set(favoriteFighterId, forKey: "favoriteFighters")
    }
    static func removeFighter(fighterId: Int){
        var index = 0
        for id in favoriteFighterId {
            if id == fighterId {
                favoriteFighterId.remove(at: index)
                saveIdToArray()
            }
            index += 1
        }
    }
    static func retriveFighters() ->[Int] { //retrive
        let defaults = UserDefaults.standard
        let array = defaults.array(forKey: "favoriteFighters")  as? [Int] ?? [Int]()
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
    static func containsId(fighterId: Int) -> Bool {
        if retriveFighters().contains(fighterId){
            return true
        } else {
            return false
        }
    }
    static func getFightersFromId (fighterIds: [Int], fighters: [UFCFighter]) -> [UFCFighter] {
        var arr = [UFCFighter]()
        for fighter in fighters {
            if let id = fighter.id {
                if fighterIds.contains(id){
                arr.append(fighter)
                }
            }
        }
        return arr
    }
}
