//
//  MovieRepository.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine

final class MovieRepository: NSObject {
    typealias MovieInstance = (LocalDataSource, RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocalDataSource
    
    private init(locale: LocalDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let shareInstance:MovieInstance = { localRepo, remoteRepo in
        return MovieRepository(locale: localRepo, remote: remoteRepo)
    }
    
}

extension MovieRepository: MovieRepositoryProtocol {
    func removeFavorite(movieID: String) -> AnyPublisher<Bool, Error> {
        return self.locale.removeFavorite(movieID: movieID)
            .map {$0 }
            .eraseToAnyPublisher()
    }
    
    func cekFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        let data = MovieMapper.mapMovieDomainToFavoriteEntites(input: movie)
        return self.locale.cekFavorite(from: data)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func deleteFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        let data = MovieMapper.mapMovieDomainToFavoriteEntites(input: movie)
        return self.locale.deleteFavoriteMovie(from: data)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func addFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        let data = MovieMapper.mapMovieDomainToFavoriteEntites(input: movie)
        return self.locale.addFavoriteMovie(from: data)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func getFavorite() -> AnyPublisher<[MovieModel], Error> {
        return self.locale.getFavorite()
            .map { MovieMapper.mapMovieFavoriteToDomain(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getPopularMovies() -> AnyPublisher<[MovieModel], Error> {
        return self.locale.getPopularMovies()
            .flatMap { result -> AnyPublisher<[MovieModel], Error> in
                if result.isEmpty {
                    return self.remote.getPopularMovies()
                        .map { MovieMapper.mapMovieResponseToPopularEntities(input: $0)}
                        .flatMap { self.locale.addPopularMovie(from: $0)}
                        .filter{ $0 }
                        .flatMap{ _ in self.locale.getPopularMovies()
                        .map{ MovieMapper.mapPopularMovieEntitiesToDomain(input: $0) }
                        }.eraseToAnyPublisher()
                }else {
                    return self.locale.getPopularMovies()
                        .map { MovieMapper.mapPopularMovieEntitiesToDomain(input: $0)}.eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getPlayingMovies() -> AnyPublisher<[MovieModel], Error> {
        return self.locale.getPlayingNow()
            .flatMap{ result -> AnyPublisher<[MovieModel], Error> in
                if result.isEmpty {
                    return self.remote.getPlayingNow()
                        .map { MovieMapper.mapMovieResponseToPlayingEntities(input: $0)}
                        .flatMap { self.locale.addPlayingMovie(from: $0)}
                        .filter { $0 }
                        .flatMap { _ in self.locale.getPlayingNow()
                        .map {MovieMapper.mapPlayingMovieEntitiesToDomain(input: $0)}
                        }.eraseToAnyPublisher()
                }else {
                    return self.locale.getPlayingNow()
                        .map { MovieMapper.mapPlayingMovieEntitiesToDomain(input: $0)}.eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    
}
