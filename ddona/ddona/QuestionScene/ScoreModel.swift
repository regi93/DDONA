//
//  ScoreModel.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import Foundation

struct ScoreModel {
    
    struct Request: Encodable {
        let mbtiScroes : scoreSet
        struct scoreSet: Encodable {
            let E = 0
            let I = 0
            let S = 0
            let N = 0
            let T = 0
            let F = 0
            let P = 0
            let J = 0
        }
    }
    
    struct Response: Decodable {
          let type: String
          let name: String
          let description: String
          let imageName: String
        
    }
}
