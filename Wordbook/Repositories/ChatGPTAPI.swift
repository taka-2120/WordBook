//
//  ChatGPTAPI.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/31/23.
//

import Foundation

enum PromptMode: String {
    case synonyms = "synonyms"
    case antonyms = "antonyms"
    case examples = "short example sentences"
    
    var format: String {
        switch self {
        case .synonyms: return "xxx, xxx, xxx, xxx: xxx is the synonym"
        case .antonyms: return "xxx, xxx, xxx, xxx: xxx is the antonym"
        case .examples: return "xxx\nxxx\nxxx\nxxx: xxx is the example sentence without prefix"
        }
    }
}

func fetchGPTResult(for word: String, mode: PromptMode) async throws -> [String]? {
    let apiUrl = URL(string: "https://api.openai.com/v1/completions")!

    var request = URLRequest(url: apiUrl)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(ENV().openAIApiKey)", forHTTPHeaderField: "Authorization")

    let parameters: [String : Any] = [
        "model": "text-davinci-002",
        "prompt": "generate four English \(mode.rawValue) for \(word.lowercased()) using the following format \(mode.format)",
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
        let result = text.replacingOccurrences(of: "\n\n", with: "").components(separatedBy: mode == .examples ? "\n" : ", ")
        print(result)
        return result
    }
    return nil
}
