//
//  MovieModel.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation


struct MovieModel: Equatable, Identifiable {
    let backdropPath: String
    let id: Int
    let originalLanguage: String
    let overview: String
    let popularity: String
    let releaseDate, title: String
    let voteAverage: String
    let voteCount: Int
}
