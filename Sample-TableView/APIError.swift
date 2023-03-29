//
//  APIError.swift
//  Sample-TableView
//
//  Created by 渡邊魁優 on 2023/03/29.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case networkError
    case unknown

    var title: String {
        switch self {
        case .invalidURL:
            return "無効なURLのエラー"
        case .networkError:
            return "ネットワークエラー"
        default:
            return "不明なエラー"
        }
    }
}
