//
//  LocalDataSourceProtocol.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine
protocol LocalDataSourceProtocol: class {
    func getPopularMovies() -> AnyPublisher<[PopularMovieEntity], Error>
    func getPlayingNow() -> AnyPublisher<[PlayingNowEntity], Error>
    
    func addPopularMovie(from popular: [PopularMovieEntity]) -> AnyPublisher<Bool, Error>
    func addPlayingMovie(from playing: [PlayingNowEntity]) -> AnyPublisher<Bool, Error>
    func addFavoriteMovie(from movie: FavoriteEntity) -> AnyPublisher<Bool, Error>
    func deleteFavoriteMovie(from movie: FavoriteEntity) -> AnyPublisher<Bool, Error>
    func removeFavorite(movieID: String) -> AnyPublisher<Bool, Error>
    func cekFavorite(from movie: FavoriteEntity) -> AnyPublisher<Bool, Error>
    func getFavorite() -> AnyPublisher<[FavoriteEntity], Error>
    
}
