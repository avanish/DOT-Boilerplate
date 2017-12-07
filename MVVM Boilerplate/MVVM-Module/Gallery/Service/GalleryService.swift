//
//  GalleryService.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 07/12/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol GalleryServiceProtocol {
    func uploadGallery(_ title: String, description: String, images: [UIImage], complete: @escaping (_ posts: Gallery?, _ error: APIError? )->())
}

class GalleryService: GalleryServiceProtocol {
    func uploadGallery(_ title: String, description: String, images: [UIImage], complete: @escaping (Gallery?, APIError?) -> ()) {
        
        let parameters = [
            "title": title,
            "description": description
        ]
        
        let headers = [
            "Authorization": "Client-ID ec0dafcf7a9a9ae"
        ]
        
        let urlAPI = "https://api.imgur.com/3/image"
        APIManager.didUpload(url: urlAPI, method: .post, parameters: parameters, imageParameters: images, headers: headers) { (response, success) in
            
            if success == true {
                if let responseJson = response {
                    let jsonModel = Mapper<Gallery>().map(JSONString: responseJson)
                    complete(jsonModel!, nil)
                }
            } else {
                 complete(nil, APIError.network)
            }
            
        }
        
    }
    
}
