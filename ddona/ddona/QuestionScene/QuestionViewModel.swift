//
//  QuestionViewModel.swift
//  ddona
//
//  Created by 유준용 on 12/15/23.
//

import Foundation

class QuestionViewModel {
    
    var question = ""
    var answer = [String]()
    var scoreStandard = [String]()
    var userScore = [String]()
    
    func fetchQuestion(process: Int, completion: @escaping ()-> Void){
        var request = URLRequest(url: URL(string: "http://43.201.67.203:8080/api/mbti/question/\(process)")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(QuestionModel.response.self, from: data!)
                self.question = json.quenstion
                self.answer.removeAll()
                for answer in json.answers {
                    let tuple = self.splitAnswer(answer: answer)
                    self.answer.append(tuple.answer ?? "")
                    self.scoreStandard.append(tuple.score ?? "")
                }
                
                print(json)
                DispatchQueue.main.async {                
                    completion()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    private func splitAnswer(answer: String)-> (answer: String?, score: String?){
        let answerAndScore = answer.components(separatedBy: "#")
        return (answer: answerAndScore.first, score: answerAndScore.last)
    }
    
    private func calculateScore(){
        
    }
    
}
//{
//  "mbtiScores": {
//    "E": 1,
//    "I": 5,
//    "S": 4,
//    "N": 2,
//    "T": 3,
//    "F": 4,
//    "P": 2,
//    "J": 4
//  }
//}
