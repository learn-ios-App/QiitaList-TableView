//
//  ArticleAPIClient.swift
//  Sample-TableView
//
//  Created by 渡邊魁優 on 2023/03/29.
//

import Foundation

class ArticleAPIClient {
    func fetchArticles() async throws -> [Article] {
        
        guard let url = URL(string: "https://qiita.com/api/v2/items") else {
            throw APIError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode([Article].self, from: data)
            return result
        } catch {
            throw APIError.networkError
        }
    }
}
