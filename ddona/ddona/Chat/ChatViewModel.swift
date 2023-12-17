//
//  ChatViewModel.swift
//  ddona
//
//  Created by 유준용 on 2023/12/16.
//

import Foundation

class ChatViewModel {
    
    struct ChatEntry: Codable {
        let type: ChatType
        let message: String
    }
    
    var recommend1 = ""
    var recommend2 = ""
    
let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0dCIsImF1dGgiOiJST0xFX1VTRVIiLCJleHAiOjE3MDI4NjkxMjR9.LlUiYe6SZnszi5gDRE2Xg0EGh4WF1KznGc2ZvxT5FrOzLtTXl7S2SJqjFdPDSyM-E9T5lHAVVvCJkgKcki2fJg"
    var chatLog: [ChatEntry] = [ChatEntry(type: .guide, message: "")]

    func save(){
        // Encoding the array to Data
        if let encodedData = try? JSONEncoder().encode(chatLog) {
            UserDefaults.standard.set(encodedData, forKey: "chatLogKey")
        }


    }
    func load(completion: @escaping () -> Void){
        // Retrieving the data from UserDefaults
        if let retrievedData = UserDefaults.standard.data(forKey: "chatLogKey"),
           let decodedData = try? JSONDecoder().decode([ChatEntry].self, from: retrievedData) {
            chatLog = decodedData
            print("✅load: ",decodedData)
            DispatchQueue.main.async{            
                completion()
            }
        }
    }
    
    func fetchRecommend(completion: @escaping () -> ()){
        var request = URLRequest(url: URL(string: "http://43.200.179.17:8080/api/clova/messages/")!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(String(data: data!, encoding: .utf8))
            print(response)
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ChatModel.Recommend.self, from: data!)
                self.recommend1 = json.recommend1
                self.recommend2 = json.recommend2
                print(String(data: data!, encoding: .utf8))
                print(response.debugDescription)
                
                DispatchQueue.main.async{
                    completion()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func sendChat(message: String, completion: @escaping () -> ()){
//        self.chatLog.append((type: .myChat, message: message))
        self.chatLog.append(ChatEntry(type: .myChat, message: message))
            
        
        var request = URLRequest(url: URL(string: "http://43.200.179.17:8080/api/clova/chat")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        do {
            let body = ChatModel.Request(message: message)
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(body)
            request.httpBody = jsonData
            print("request",request.debugDescription)
        }
        catch{
            print("Error decoding JSON: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(String(data: data!, encoding: .utf8))
            print(response)
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ChatModel.Response.self, from: data!)
                self.chatLog.append(ChatEntry(type: .chatBot, message: json.message))
                print(String(data: data!, encoding: .utf8))
                print(response.debugDescription)
                DispatchQueue.main.async{      
                    self.insertProfileImage()
                    completion()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    private func insertProfileImage(){
        var isNeedProfile = false
        var beforeType = ChatType.guide
        var newLog = [ChatEntry]()
        for (idx,chat) in self.chatLog.enumerated() {
            if chat.type == .chatBot, beforeType != .chatBot, beforeType != .chatBotProfile {
                newLog.append(ChatEntry(type: .chatBotProfile, message: ""))
            }
            beforeType = chat.type
            newLog.append(chat)
        }
        self.chatLog = newLog
        save()
    }
    
    enum ChatType: String ,Codable {
        case guide ,myChat, chatBot, chatBotProfile

    }
 
}
