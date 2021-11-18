//
//  ProfileInteractorProtocol.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation
import Combine

protocol ProfileInteractorProtocol {
    
    func getFavoriteMovie() -> AnyPublisher<[MovieModel],Error>
    
}
