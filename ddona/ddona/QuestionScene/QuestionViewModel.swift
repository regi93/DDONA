//
//  QuestionViewModel.swift
//  ddona
//
//  Created by 유준용 on 12/15/23.
//

import Foundation

class QuestionViewModel {
    
    var number = 0
    
    func fetchQuestion(){
        var request = URLRequest(url: URL(string: "http://43.201.67.203:8080/api/mbti/question/\(number)")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("1.data: \(String(data: data!, encoding: .utf8))")
            
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(QuestionModel.response.self, from: data!){
                print("#json:",json)
            }
            print("2.response: \(response)")
            print("3.error: \(error)")
            
        }.resume()
    }
}