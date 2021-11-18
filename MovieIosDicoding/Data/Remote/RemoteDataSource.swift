//
//  RemoteDataSource.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine
import Alamofire



final class RemoteDataSource: NSObject {
    
    private override init() {
    }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getDetailMove(movieId: String) -> AnyPublisher<MovieDetailResource, Error> {
        return Future<MovieDetailResource, Error> { completion in
            if let url = Route.detailMovie(movieId).apiUrl.asUrl {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieDetailResource.self) {response in
                        switch response.result {
                        case .success(let result):
                            completion(.success(result))
                        case .failure(_):
                            completion(.failure(AppError.unknownError))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getPopularMovies() -> AnyPublisher<[MovieResource], Error> {
        return Future<[MovieResource], Error> { completion in
            if let url = URL(string: Route.trending.apiUrl) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) {response in
                       
                        switch response.result {
                        case .success(let value):
                            
                            completion(.success(value.results!))
                        case .failure(_):
                            
                            completion(.failure(AppError.unknownError))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    
    
    func getPlayingNow() -> AnyPublisher<[MovieResource], Error> {
        return Future<[MovieResource],Error> { completion in
            if let url = Route.playingNow.apiUrl.asUrl {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) {response in
                        print("responsenya = \(response)")
                        switch response.result {
                        case .success(let value):
                            print("Sukses remote")
                            completion(.success(value.results!))
                        case .failure(_):
                            print("error : error tidak tau")
                            completion(.failure(AppError.unknownError))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    
    
}
