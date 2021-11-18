//
//  MovieResource.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation


struct MovieResource: Codable {
    
    let backdropPath: String?
    let id: Int?
    let originalLanguage: String?
    let overview: String?
    let popularity: Double?
    let releaseDate, title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "poster_path"
        case id
        case originalLanguage = "original_language"
        case overview, popularity
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
