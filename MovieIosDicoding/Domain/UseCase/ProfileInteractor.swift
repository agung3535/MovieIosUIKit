//
//  ProfileInteractor.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation
import Combine

class ProfileInteractor: ProfileInteractorProtocol {
    
    private let repository: MovieRepositoryProtocol
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteMovie() -> AnyPublisher<[MovieModel], Error> {
        return repository.getFavorite()
    }
    
    
}
