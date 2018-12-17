//
//  UFCFighterArticle.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/16/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

struct UFCFighterArticle: Codable {
    let id: Int
    let title: String
    let articleDate: String
    let thumbnail: String
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case articleDate = "article_date"
        case thumbnail
    }
}
