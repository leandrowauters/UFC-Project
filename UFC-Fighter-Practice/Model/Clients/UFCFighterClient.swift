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
    static func getFighterFromId (fighters: [UFCFighter], id: Int) -> String {
        var fighterName = String()
        for fighter in fighters {
            if fighter.id == id {
                guard let name = fighter.lastName else {return "no name"}
                fighterName = name
            }
        }
        return fighterName
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
final class UFCFighterNewsClient {
    static func getFighterNews(fighterId: String, completionHandler: @escaping(([UFCFighterArticle]?, UFCFighterErrors?) -> Void)) {
        guard let url = URL.init(string: "http://ufc-data-api.ufc.com/api/v3/us/fighters/\(fighterId)/news") else {completionHandler(nil, .badURL("url failed"))
            return
        }
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            if let data = data {
                do {
                    let newsData = try JSONDecoder().decode([UFCFighterArticle].self, from: data)
                    completionHandler(newsData, nil)
                } catch {
                    completionHandler(nil, .badDecoding(error))
                }
            }
            
            }.resume()
    }
}
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

