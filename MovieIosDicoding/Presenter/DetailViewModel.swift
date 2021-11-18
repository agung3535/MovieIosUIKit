//
//  DetailViewModel.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation
import Combine
class DetailViewModel: ObservableObject {

    private let detailInteractor: DetailInteractorProtocol
    let movie = CurrentValueSubject<MovieModel,Never>(MovieModel(backdropPath: "", id: 0, originalLanguage: "", overview: "", popularity: "", releaseDate: "", title: "", voteAverage: "", voteCount: 0))
    private var cancelables = Set<AnyCancellable>()
    let isFavorite = CurrentValueSubject<Bool,Never>(false)
    let errorMessage = CurrentValueSubject<String,Never>("")
  
    init(detailInteractor: DetailInteractorProtocol) {
        self.detailInteractor = detailInteractor
        movie.send(detailInteractor.getDetailMovie())
    }
    
    func setFavorite(movie: MovieModel) {
        detailInteractor.addFavorite(movie: movie)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {[weak self] (completion) in
                switch completion {
                case .finished:
                    print("finish")
                case .failure(let error):
                    self?.errorMessage.send(error.localizedDescription)
                    print("error : \(error)")
                }
            }, receiveValue: {[weak self] (result) in
                print("result akhir :\(result)")
                self?.isFavorite.send(result)
            }).store(in: &cancelables)
        
    }
    
    func deleteFavorite(movie: MovieModel) {
        detailInteractor.deleteFavorite(movie: movie)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {(completion) in
                switch completion {
                case .finished:
                    print("Finish")
                case .failure(let error):
                    print("error : \(error)")
                }
            }, receiveValue: {[weak self] (result) in
                self?.isFavorite.send(!result)
            }).store(in: &cancelables)
    }
    
    func cekFavorite(movie: MovieModel) {
        detailInteractor.cekFavorite(movie: movie)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {[weak self] (completion) in
                switch completion {
                case .finished:
                    print("selesai")
                case .failure(let error):
                    self?.errorMessage.send(error.localizedDescription)
                }
            }, receiveValue: { [weak self] (result) in
                print("cek favorite = \(result)")
                self?.isFavorite.send(result)
            }).store(in: &cancelables)
    }
    
    func removeFavorite(movieId: String) {
        detailInteractor.removeFavorite(movieId: movieId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {[weak self] (completion) in
                switch completion {
                case .finished:
                    print("finish")
                case .failure(let error):
                    self?.errorMessage.send(error.localizedDescription)
                }
            }, receiveValue: {[weak self] (result) in
                self?.isFavorite.send(false)
            }).store(in: &cancelables)
    }
    
    
}
