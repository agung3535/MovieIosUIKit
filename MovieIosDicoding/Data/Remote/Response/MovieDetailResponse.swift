//
//  MovieDetailResponse.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation


struct MovieDetailResource: Codable {
    let backdropPath: String?
    let genres: [GenreResource]?
    let id: Int?
    let originalLanguage, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let status, tagline, title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
      
        case backdropPath = "backdrop_path"
        case genres, id
        case originalLanguage = "original_language"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case status, tagline, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
