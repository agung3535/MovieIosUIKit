//
//  LocalDataSource.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine
import RealmSwift



final class LocalDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }
    
    
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}

extension LocalDataSource: LocalDataSourceProtocol {
    
    
    func getFavorite() -> AnyPublisher<[FavoriteEntity], Error> {
        return Future<[FavoriteEntity],Error> { completion in
            if let realm = self.realm {
                let favoriteMovies: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(favoriteMovies.toArray(ofType: FavoriteEntity.self)))
            }else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
   
    func getPopularMovies() -> AnyPublisher<[PopularMovieEntity], Error> {
        return Future<[PopularMovieEntity], Error> { completion in
            
            if let realm = self.realm {
                let popularMovies: Results<PopularMovieEntity> = {
                    realm.objects(PopularMovieEntity.self)
                        .sorted(byKeyPath: "releaseData", ascending: false)
                }()
                
                completion(.success(popularMovies.toArray(ofType: PopularMovieEntity.self)))
            }else {
                
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getPlayingNow() -> AnyPublisher<[PlayingNowEntity], Error> {
        return Future<[PlayingNowEntity], Error> { completion in
            print("masuk local playing")
            if let realm = self.realm {
                let playingMovies: Results<PlayingNowEntity> = {
                    realm.objects(PlayingNowEntity.self)
                        .sorted(byKeyPath: "releaseData", ascending: false)
                }()
                print("playing local isinya = \(playingMovies)")
                completion(.success(playingMovies.toArray(ofType: PlayingNowEntity.self)))
            }else {
                print("invalid realm")
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addPopularMovie(from popular: [PopularMovieEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for populars in popular {
                            realm.add(populars, update: .all)
                        }
                        
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addPlayingMovie(from playing: [PlayingNowEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool ,Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for play in playing {
                            realm.add(play, update: .all)
                        }
                        completion(.success(true))
                    }
                }catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addFavoriteMovie(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return Future<Bool ,Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        let fav = FavoriteEntity()
                        fav.title = movie.title
                        fav.overview = movie.overview
                        fav.popularity = movie.popularity
                        fav.voteAverage = movie.voteAverage
                        fav.backdropPath = movie.backdropPath
                        fav.voteCount = movie.voteCount
                        fav.id = movie.id
                        fav.originalLanguage = movie.originalLanguage
                        fav.releaseData = movie.releaseDate
                        realm.add(fav)
                        completion(.success(true))
                    }
                }catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteFavoriteMovie(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
//                print("movie id = \(movieID)")
                let predicate = NSPredicate(format: "id == %d", movie.id)
                let data: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .filter(predicate)
                }()
                print("data dari realm = \(data.toArray(ofType: FavoriteEntity.self))")
                do {

                    try? realm.write {
                        realm.delete(data)
                        completion(.success(true))
                    }

                }catch {
                    completion(.success(false))
                }
            }else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func cekFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let predicate = NSPredicate(format: "id == %d", movie.id)
//                let result = realm.objects(FavoriteEntity.self).filter(predicate)
                let favMovie: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .filter(predicate)
                }()
                print("predicate = \(predicate)")
                print("data dari cek = \(favMovie.toArray(ofType: FavoriteEntity.self))")
                if favMovie.toArray(ofType: FavoriteEntity.self).count != 0 {
                    completion(.success(true))
                }else{
                    completion(.success(false))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeFavorite(movieID: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                print("movie id = \(movieID)")
                let predicate = NSPredicate(format: "id == %d", movieID)
                let data: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .filter(predicate)
                }()
                print("data dari realm = \(data.toArray(ofType: FavoriteEntity.self))")
                do {

                    try? realm.write {
                        realm.delete(data)
                        completion(.success(true))
                    }

                }catch {
                    completion(.success(false))
                }
            }else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    
}
