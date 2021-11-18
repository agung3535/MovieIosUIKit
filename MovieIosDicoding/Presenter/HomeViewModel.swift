//
//  HomeViewModel.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import Combine
import RealmSwift

class HomeViewModel: ObservableObject {
    
    private var cancelables = Set<AnyCancellable>()
    private let homeProtocol = Injection.init().provideHome()
    let popularMovie = CurrentValueSubject<[MovieModel],Never>([MovieModel]())
    let playingMovie = CurrentValueSubject<[MovieModel],Never>([MovieModel]())
    let loadingTrendingState = CurrentValueSubject<Bool,Never>(true)
    let loadingPlayingState = CurrentValueSubject<Bool,Never>(true)
    let errorMessage = CurrentValueSubject<String,Never>("")
    let errorPlayingMsg = CurrentValueSubject<String,Never>("")
    
    
    func getPopularMovie() {
        homeProtocol.getPopularMovie()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .finished:
                    self?.loadingTrendingState.send(false)
                case .failure(_):
                    self?.errorMessage.send(String(describing: completion))
                }
            }, receiveValue: { [weak self] (movieData) in
                self?.popularMovie.send(movieData)
            })
            .store(in: &cancelables)
    }
    
    func getPlayingNow() {
        homeProtocol.getPlayingNow()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {[weak self] (completion) in
                switch completion {
                case .finished:
                    self?.loadingPlayingState.send(false)
                case .failure(_):
                    self?.errorPlayingMsg.send(String(describing: completion))
                }
            }, receiveValue: {[weak self] (playingData) in
                self?.playingMovie.send(playingData)
            }).store(in: &cancelables)
    }
    
}
