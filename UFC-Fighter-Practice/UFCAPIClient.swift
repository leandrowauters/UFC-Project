//
//  UFCAPIClient.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/10/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import Foundation

enum UFCFighterErrors {
    case badURL (String)
    case badData (Error)
    case badDecoding(Error)
}




final class UFCAPIClient: Codable {
    static func getFighter (completionHandler: @escaping(([UFCFighter]?, UFCFighterErrors?) -> Void)){
        guard let url = URL.init(string: "http://ufc-data-api.ufc.com/api/v1/us/fighters") else
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

