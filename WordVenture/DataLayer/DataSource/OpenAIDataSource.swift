//
//  OpenAIDataSource.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

final class OpenAIDataSource: NSObject, Sendable {
    
    class func fetchGeneratedText(for word: String, mode: PromptMode) async throws -> [String]? {
        let apiUrl = URL(string: "https://api.openai.com/v1/completions")!

        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ENV().openAIApiKey)", forHTTPHeaderField: "Authorization")

        let parameters: [String : Any] = [
            "model": "text-davinci-002",
            "prompt": "generate four \(mode.rawValue) for \(word.lowercased()) in entered language following the format: \(mode.format)",
            "max_tokens": 50,
            "temperature": 0.5,
            "n": 1,
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "HTTPError", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: nil)
        }
        
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        print(json)
        
        if let choices = json["choices"] as? [[String: Any]],
           let text = choices.first?["text"] as? String {
            let results = text.replacingOccurrences(of: "\n\n", with: "").components(separatedBy: mode == .examples ? "\n" : ", ")
            print(results)
            return results
        }
        return nil
    }
}
