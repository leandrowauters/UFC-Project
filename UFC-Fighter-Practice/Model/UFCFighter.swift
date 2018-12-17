//
//  UFCFighter.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/10/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

struct UFCFighter: Codable {
    let id: Int?
    let wins: Int?
    let losses: Int?
    let lastName: String?
    let weightClass: String?
    let titleHolder: Bool
    let draws: Int?
    let firstName: String
    let fighterStatus: String?
    let poundForPoundRank: String?
    let leftFullBodyImage: String?
    let thumbnail: String?
    let profileImage: String?
    private enum CodingKeys: String, CodingKey {
        case id
        case wins
        case losses
        case lastName = "last_name"
        case weightClass = "weight_class"
        case titleHolder = "title_holder"
        case draws
        case firstName = "first_name"
        case fighterStatus = "fighter_status"
        case poundForPoundRank = "pound_for_pound_rank"
        case leftFullBodyImage = "left_full_body_image"
        case thumbnail
        case profileImage = "profile_image"
    }
}


    



