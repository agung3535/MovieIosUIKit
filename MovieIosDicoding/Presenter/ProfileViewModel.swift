//
//  ProfileViewModel.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    private var cancelables = Set<AnyCancellable>()
    private let profileProtocol = Injection.init().provideProfile()
    var favMovie = CurrentValueSubject<[MovieModel], Never>([MovieModel]())
    var errorMessage = CurrentValueSubject<String, Never>("")
    var hasFavorite = CurrentValueSubject<Bool, Never>(false)
    
    func getFavorite() {
        profileProtocol.getFavoriteMovie()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {[weak self] (completion) in
                switch completion {
                case .finished:
                    print("Finish")
                case .failure(let error):
                    self?.errorMessage.send(error.localizedDescription)
                }
            }, receiveValue: {[weak self] (result) in
                if !result.isEmpty {
                    self?.hasFavorite.send(true)
                    self?.favMovie.send(result)
                }
            }).store(in: &cancelables)
    }
    
    
}
