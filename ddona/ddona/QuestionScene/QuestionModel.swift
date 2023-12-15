//
//  QuestionModel.swift
//  ddona
//
//  Created by 유준용 on 12/15/23.
//

import Foundation

struct QuestionModel: Codable {
    
    struct request: Encodable { }
    
    struct response: Decodable {
        let quenstion: String
        let answers: [String]
    }
}
