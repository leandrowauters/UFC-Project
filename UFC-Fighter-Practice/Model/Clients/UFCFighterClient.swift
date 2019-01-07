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
        guard let spanishUrl = URL.init(string: "http://ufc-data-api.ufc.com/api/v3/5/news") else
            {completionHandler(nil, .badURL("url failed"))
                return
        }
        if LanguageClient.chosenLanguage == .spanish{
        URLSession.shared.dataTask(with: spanishUrl){(data, response, error) in
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
        } else {
        
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
final class UFCEventDetailsClient: Codable{
    static func getEventDetails (eventId: String, completionHandler: @escaping(([UFCEventDetails]?, UFCFighterErrors?) -> Void)){
        guard let url = URL.init(string: "http://ufc-data-api.ufc.com/api/v3/events/\(eventId)/fights") else {completionHandler(nil, .badURL("url failed"))
            return
        }
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            if let data = data {
                do{
                    let eventData = try JSONDecoder().decode([UFCEventDetails].self, from: data)
                    completionHandler(eventData, nil)
                }catch{
                    completionHandler(nil, .badDecoding(error))
                }
            }
        }.resume()
    }
}



