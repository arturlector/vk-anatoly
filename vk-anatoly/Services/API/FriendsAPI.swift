//
//  FriendsAPI.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 08.12.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class FriendsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    
    
    func getFriends(completion: @escaping([FriendDTO])->()) {
        
        //    //https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
        //
        //        userId
        //        order = name
        //        count = 5
        //        fields = photo_100
        //        access_token
        //        v = "5.131"
            
        
        let method = "/friends.get"
        let url = baseUrl + method
        
        let params: [String: String] = [
            "userId": Session.shared.userId,
            "order": "name",
            "count": "100",
            "fields": "photo_100",
            "access_token": Session.shared.token,
            "v": "5.131"
        ]
        
        //GET - получение
        //POST - создание
        //PUT/PATCH - изменение
        //DELETE - удаление
        
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            
            guard let data = response.data else { return }

            print(data.prettyJSON)
            
            do {
                
                let friendsData = try JSON(data)["response"]["items"].rawData()
                
                let friends = try JSONDecoder().decode([FriendDTO].self, from: friendsData)
                
                completion(friends)
                
            } catch {
                print(error)
            }
        }
    }


}
