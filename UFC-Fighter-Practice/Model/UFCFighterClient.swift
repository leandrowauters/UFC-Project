//
//  UFCAPIClient.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/10/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

enum UFCFighterErrors {
    case badURL (String)
    case badData (Error)
    case badDecoding(Error)
}




final class UFCFighterClient: Codable {
    static func getFighter (completionHandler: @escaping(([UFCFighter]?, UFCFighterErrors?) -> Void)){
        guard let url = URL.init(string: "http://ufc-data-api.ufc.com/api/v3/us/fighters") else
            {completionHandler(nil, .badURL("url failed"))
                return
            }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            if let data = data {
                do{
                    let fighterData = try JSONDecoder().decode([UFCFighter].self, from: data)
                    completionHandler(fighterData, nil)
                } catch {
                   completionHandler(nil, .badDecoding(error))
                }
            }
        }.resume()
    }

}
final class UFCEventClinet: Codable{
    static func getEvent (completionHandler: @escaping(([UFCEvent]?, UFCFighterErrors?) -> Void)){
        guard let url = URL.init(string: "http://ufc-data-api.ufc.com/api/v3/us/events") else {completionHandler(nil, .badURL("url failed"))
            return
        }
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            if let data = data {
                do{
                    let eventData = try JSONDecoder().decode([UFCEvent].self, from: data)
                    completionHandler(eventData, nil)
                }catch{
                    completionHandler(nil, .badDecoding(error))
                }
            }
        }.resume()
    }
}
final class UFCNewsClient: Codable {
    static func getNews (completionHandler: @escaping(([UFCNews]?, UFCFighterErrors?) -> Void )) {
        guard let url = URL.init(string: "http://ufc-data-api.ufc.com/api/v3/us/news") else
        {completionHandler(nil, .badURL("url failed"))
            return
        }
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            if let data = data {
                do {
                    let newsData = try JSONDecoder().decode([UFCNews].self, from: data)
                    completionHandler(newsData, nil)
            } catch {
                completionHandler(nil, .badDecoding(error))
            }
        }
        
    }.resume()
}
}
final class ImageClient {
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


