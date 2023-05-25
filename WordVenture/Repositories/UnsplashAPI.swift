//
//  UnsplashAPI.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/25/23.
//

import Foundation

func fetchUnsplashPhotos(for word: String) async throws -> [String] {
    let url = "https://api.unsplash.com/search/photos/?page=1&query=\(word)&client_id=\(ENV().unsplashAccessKey)"
    
    let apiUrl = URL(string: url)!

    var request = URLRequest(url: apiUrl)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw NSError(domain: "HTTPError", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: nil)
    }
    
    let imagesJson = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    print(imagesJson["results"] as! NSArray)
    let imagesArray = imagesJson["results"] as! NSArray
    var unsplashImageUrls = [String]()

    for imageJson in imagesArray {
        let url = ((imageJson as AnyObject)["links"]!! as AnyObject)["download"]!! as! String
        unsplashImageUrls.append(url)
    }
    return unsplashImageUrls
}
