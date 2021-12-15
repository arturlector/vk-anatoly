//
//  PhotoAPI.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 15.12.2021.
//

import Foundation
import Alamofire


final class PhotoAPI {
    
    
    var baseURL = "https://api.vk.com/method"
    
    func getPhotos(complition: @escaping ([PhotoDTO])->()) {
        let method = "/photos.get"
        let url = baseURL + method
        let params = ["owner_id": Session.shared.userId,
                             "album_id": "wall",
                             "rev": "0",
                             "photo_sizes": "1",
                             "count": "6",
                             "access_token": Session.shared.token,
                             "v": "5.131"
        ]
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            guard let data = response.data else { return}
            
            let welcome = try? JSONDecoder().decode(Welcome1.self, from: data)
            guard let photo = welcome?.response.items else {return}
            
            complition(photo)
            print(photo)
            
            
        }
    }
}
