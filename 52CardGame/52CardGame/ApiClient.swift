//
//  ApiClient.swift
//  52CardGame
//
//  Created by Administrator on 31/10/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import Foundation



class CardAPIClient : NSObject {
    
    var cards : [Card]?
    
    func getCards(endPoint: String, completion: @escaping ([Card]?) -> Void) {
        
        guard  let url = URL(string: endPoint) else { return }
        
        let task =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            /// parse the result as JSON, since that's what the API provides
            do {
                
                let cardData = try JSONDecoder().decode([Card].self, from: responseData)
                
                completion(cardData)
                
        
            } catch let jsonError {
                print(jsonError)
                print("record not found")
                
            }
            
        }
        task.resume()
        return
    }
    
}
