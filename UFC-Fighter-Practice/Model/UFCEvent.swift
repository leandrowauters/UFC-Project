//
//  Event.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/12/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

struct UFCEvent: Codable {
    let event_dategmt: String//REMOVE _ //ALSO USE NSCAChE (LOOK EVENT PROJECT)
    let base_title: String
    let title_tag_line: String?
    let feature_image: String
    let arena: String
    let location: String
}
