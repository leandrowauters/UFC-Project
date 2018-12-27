//
//  UFCEventDetails.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/23/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

struct UFCEventDetails: Codable {
    let fighter2record: String
    let fightercardOrder: Int?
    let fighter1record: String
    let fighter1Id: Int
    let fighter2Id: Int
    let fighter1IsWinner: Bool?
    let fighter2IsWinner: Bool?
    struct Result: Codable{
        var Method: String?
    }
    let result: Result?
    private enum CodingKeys: String, CodingKey{
        case fighter2record
        case fightercardOrder = "fightercard_order"
        case fighter1record
        case fighter1Id = "fighter1_id"
        case fighter2Id = "fighter2_id"
        case fighter1IsWinner = "fighter1_is_winner"
        case fighter2IsWinner = "fighter2_is_winner"
        case result
    }
}
