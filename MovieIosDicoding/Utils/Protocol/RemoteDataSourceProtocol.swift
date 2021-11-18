//
//  RemoteDataSourceProtocol.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol: class {
    func getPopularMovies() -> AnyPublisher<[MovieResource], Error>
    func getPlayingNow() -> AnyPublisher<[MovieResource], Error>
    func getDetailMove(movieId: String) -> AnyPublisher<MovieDetailResource, Error>
}
