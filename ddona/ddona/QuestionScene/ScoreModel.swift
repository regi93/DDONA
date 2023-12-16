//
//  ScoreModel.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import Foundation

struct ScoreModel {
    
    struct Request: Encodable {
        
        var mbtiScores : scoreSet
        
        struct scoreSet: Encodable {
            var E = 0
            var I = 0
            var S = 0
            var N = 0
            var T = 0
            var F = 0
            var P = 0
            var J = 0
        }
    }
    
    struct Response: Decodable {
          let type: String
          let name: String
          let description: String
          let imageName: String
        
    }
}
