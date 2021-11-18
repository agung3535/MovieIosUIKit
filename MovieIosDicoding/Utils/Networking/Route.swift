//
//  Route.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation


enum Route {
    
    static let baseUrl = "https://api.themoviedb.org/3"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    case genre
    case playingNow
    case trending
    case detailMovie(String)
    
    var apiUrl: String {
        switch self {
        case .genre:
            return "\(Route.baseUrl)/genre/movie/list?api_key=80b5fd4d416c198a2917e73df9fec5d9"
        case .playingNow:
            return "\(Route.baseUrl)/movie/now_playing?api_key=80b5fd4d416c198a2917e73df9fec5d9"
        case .trending:
            return "\(Route.baseUrl)/movie/popular?api_key=80b5fd4d416c198a2917e73df9fec5d9"
        case .detailMovie(let movieId):
            return "\(Route.baseUrl)/movie/\(movieId)/?api_key=80b5fd4d416c198a2917e73df9fec5d9"
        }
    }
    
    
}
