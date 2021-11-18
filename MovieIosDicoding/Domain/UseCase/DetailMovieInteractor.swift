//
//  DetailMovieInteractor.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation
import Combine

class DetailMovieInteractor: DetailInteractorProtocol {
    
    
    
   
    private let repository: MovieRepositoryProtocol
    private let movie: MovieModel
    
    required init(repository: MovieRepositoryProtocol, movie: MovieModel) {
        self.repository = repository
        self.movie = movie
    }
    func getDetailMovie() -> MovieModel {
        return movie
    }
    
    func deleteFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return repository.deleteFavorite(movie: movie)
    }
    
    func addFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return repository.addFavorite(movie: movie)
    }
    
    func cekFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return repository.cekFavorite(movie: movie)
    }
    
    func removeFavorite(movieId: String) -> AnyPublisher<Bool, Error> {
        return repository.removeFavorite(movieID: movieId)
    }
    
    
}
