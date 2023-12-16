//
//  ChatModel.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import Foundation

struct ChatModel {
    
    struct Request: Encodable {
        let message: String
    }
    
    struct Response: Decodable {
        let message: String
    }
    
    struct Recommend: Decodable{
        let recommend1: String
        let recommend2: String
        
    }
}
