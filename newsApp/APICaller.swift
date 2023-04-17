//
//  APICaller.swift
//  newsApp
//
//  Created by LI,JYUN-SIAN on 14/4/23.
//

import Foundation

final class APICaller{
    
    static let shared = APICaller()
    struct Constansts {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-03-17&sortBy=publishedAt&apiKey=548ae93992f24899a284bba906a6cf12")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping(Result<[Article],Error>) -> Void){
        guard let url = Constansts.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
            
        }
        task.resume()
    }
}
// models

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String

}

struct Source: Codable {
    let name: String
}



