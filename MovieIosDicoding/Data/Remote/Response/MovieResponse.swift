//
//  MovieResponse.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation


struct MovieResponse: Codable {
    let page: Int?
    let results: [MovieResource]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
