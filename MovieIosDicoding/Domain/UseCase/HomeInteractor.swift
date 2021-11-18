//
//  HomeInteractor.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine


class HomeInteractor: HomeInteractorProtocol {
    
    func getPopularMovie() -> AnyPublisher<[MovieModel], Error> {
        return repository.getPopularMovies()
    }
    
    func getPlayingNow() -> AnyPublisher<[MovieModel], Error> {
        return repository.getPlayingMovies()
    }
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
      self.repository = repository
    }
    
}
