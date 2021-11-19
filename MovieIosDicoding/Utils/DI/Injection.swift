//
//  Injection.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import RealmSwift


final class Injection: NSObject {
    
    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let realm = try? Realm()
        let locale: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        return MovieRepository.shareInstance(locale,remote)
    }
    
    func provideHome() -> HomeInteractorProtocol {
        let repository = provideMovieRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(movie: MovieModel) -> DetailMovieInteractor {
      let repository = provideMovieRepository()
      return DetailMovieInteractor(repository: repository, movie: movie)
    }
    
    func provideProfile() -> ProfileInteractorProtocol {
        let repository = provideMovieRepository()
        return ProfileInteractor(repository: repository)
    }
    
    
    
    
}
