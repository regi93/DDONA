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
    var calculateResult: ScoreModel.Response?
    
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
                DispatchQueue.main.async {                
                    completion()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    private func fetchMBTIResult(body: ScoreModel.Request, completion: @escaping ()-> Void){
        var request = URLRequest(url: URL(string: "http://43.201.67.203:8080/api/mbti/calculate")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(body)
            request.httpBody = jsonData
            print("request",request.debugDescription)
        }
        catch{
            print("Error decoding JSON: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ScoreModel.Response.self, from: data!)
                self.calculateResult = json
                completion()
                print(String(data: data!, encoding: .utf8))
                print(response.debugDescription)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    private func splitAnswer(answer: String)-> (answer: String?, score: String?){
        let answerAndScore = answer.components(separatedBy: "#")
        return (answer: answerAndScore.first, score: answerAndScore.last)
    }
    
    func selectedAnswer(idx: Int){
        userScore.append(scoreStandard[idx])
    }
    
    func calculateScore(completion: @escaping () -> Void){
        
        var scoreSet = ScoreModel.Request.scoreSet()
        
        for ele in ["E","I","S"] {
            switch ele{
            case "E":
                scoreSet.E += 1
            case "I":
                scoreSet.I += 1
            case "S":
                scoreSet.S += 1
            case "N":
                scoreSet.N += 1
            case "T":
                scoreSet.T += 1
            case "F":
                scoreSet.F += 1
            case "P":
                scoreSet.P += 1
            case "J":
                scoreSet.J += 1
            default: break
            }
        }
        
        let request = ScoreModel.Request(mbtiScores: scoreSet)
        self.fetchMBTIResult(body: request) {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

