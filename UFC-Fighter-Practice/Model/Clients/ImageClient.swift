//
//  ImageClient.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 1/3/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

public final class ImageHelper {
    // Singleton instance to have only one instance in the app of the imageCache
   static let defaultImageURL = "http://imagec.ufc.com/http%253A%252F%252Fmedia.ufc.tv%252Ffeatures%252F019907_WEB_EventPlaceholderRebrand_PPV.jpg?-mw500-mh500-tc1"
    
    private init() {
        imageCache = NSCache<NSString, UIImage>()
        imageCache.countLimit = 100 // number of objects
        imageCache.totalCostLimit = 10 * 1024 * 1024 // max 10MB used
    }
    public static let shared = ImageHelper()
    
    private var imageCache: NSCache<NSString, UIImage>
    
    public func fetchImage(urlString: String, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
                return
            }
            if let response = response {
                // response.allHeaderFields dictionary contains useful header information such as Content-Type, Content-Length
                // response also has the mimeType, such as image/jpeg, text/html, image/png
                let mimeType = response.mimeType ?? "no mimeType found"
                var isValidImage = false
                switch mimeType {
                case "image/jpeg":
                    isValidImage = true
                case "image/png":
                    isValidImage = true
                default:
                    isValidImage = false
                }
                if !isValidImage {
                    completionHandler(AppError.badMimeType(mimeType), nil)
                    return
                } else if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        if let image = image {
                            ImageHelper.shared.imageCache.setObject(image, forKey: urlString as NSString)
                        }
                        completionHandler(nil, image)
                    }
                }
            }
        }
    }
    
    public func image(forKey key: NSString) -> UIImage? {
        return imageCache.object(forKey: key)
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
