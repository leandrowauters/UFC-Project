//
//  ImageClient.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 1/3/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

final class ImageClient {
    static let defaultImageURL = "http://imagec.ufc.com/http%253A%252F%252Fmedia.ufc.tv%252Ffeatures%252F019907_WEB_EventPlaceholderRebrand_PPV.jpg?-mw500-mh500-tc1"
    static func getImage(stringURL: String) -> UIImage? {
        guard let myImageURL = URL.init(string: stringURL) else {
            return nil
        }
        do {
            let data = try Data.init(contentsOf: myImageURL)
            guard let image = UIImage.init(data: data) else {return nil}
            return image
        } catch {
            print(error)
            return nil
        }
    }
}

final class ColorClient{
    static func changeCellColor (indexPathRow: Int, cell: UITableViewCell){
        if indexPathRow % 2 == 0{
            cell.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
}
