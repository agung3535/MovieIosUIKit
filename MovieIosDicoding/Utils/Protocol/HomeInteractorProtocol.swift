//
//  HomeInteractorProtocol.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine

protocol HomeInteractorProtocol {
    func getPopularMovie() -> AnyPublisher<[MovieModel], Error>
    func getPlayingNow() -> AnyPublisher<[MovieModel], Error>
    
}
