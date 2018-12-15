//
//  Event.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/12/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

struct UFCEvent: Codable {
    let eventDategmt: String//REMOVE _ //ALSO USE NSCAChE (LOOK EVENT PROJECT)
    let baseTitle: String
    let titleTagLine: String?
    let featureImage: String
    let arena: String
    let location: String
    private enum CodingKeys: String, CodingKey{
        case eventDategmt = "event_dategmt"//REMOVE _ //ALSO USE NSCAChE (LOOK EVENT PROJECT)
        case baseTitle = "base_title"
        case titleTagLine = "title_tag_line"
        case featureImage = "feature_image"
        case arena
        case location
    }
}
