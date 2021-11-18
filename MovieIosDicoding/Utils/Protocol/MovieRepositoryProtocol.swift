//
//  MovieRepositoryProtocol.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func getPopularMovies() -> AnyPublisher<[MovieModel], Error>
    func getPlayingMovies() -> AnyPublisher<[MovieModel], Error>
    func addFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func deleteFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func removeFavorite(movieID: String) -> AnyPublisher<Bool, Error>
    func cekFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func getFavorite() -> AnyPublisher<[MovieModel], Error>
}
