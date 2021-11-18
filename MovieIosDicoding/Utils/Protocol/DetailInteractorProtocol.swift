//
//  DetailInteractorProtocol.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation
import Combine

protocol DetailInteractorProtocol {
  
    func getDetailMovie() -> MovieModel
    func addFavorite(movie: MovieModel) -> AnyPublisher<Bool,Error>
    func deleteFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
    func removeFavorite(movieId: String) -> AnyPublisher<Bool, Error>
    func cekFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
}
