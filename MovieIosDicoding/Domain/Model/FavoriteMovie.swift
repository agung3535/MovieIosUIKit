//
//  FavoriteMovie.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation



struct FavoriteMovie: Equatable, Identifiable {
    let backdropPath: String
    let id: Int
    let originalLanguage: String
    let overview: String
    let popularity: Double
    let releaseDate, title: String
    let voteAverage: Double
    let voteCount: Int
    
}
