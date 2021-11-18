//
//  ViewController.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import UIKit
import SwiftUI
import Combine
class ViewController: UIViewController {
    
//    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var playingNowCollectionView: UICollectionView!
    private let homeViewMode = HomeViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    var genre:[String] = ["Action"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        playingNowCollectionView.delegate = self
        playingNowCollectionView.dataSource = self
        registerCell()
        callApi()
        homeViewMode.popularMovie.sink{[weak self] (_) in
            self?.trendingCollectionView.reloadData()
        }.store(in: &subscriptions)
        homeViewMode.playingMovie.sink{[weak self] (_) in
            self?.playingNowCollectionView.reloadData()
        }.store(in: &subscriptions)
    }

    func registerCell(){

        trendingCollectionView.register(UINib(nibName: TrendingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        playingNowCollectionView.register(UINib(nibName: PlayingNowCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PlayingNowCollectionViewCell.identifier)
    }
    
    func callApi() {
        homeViewMode.getPopularMovie()
        homeViewMode.getPlayingNow()

    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case trendingCollectionView:
            return homeViewMode.popularMovie.value.count
        case playingNowCollectionView:
            return homeViewMode.playingMovie.value.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case trendingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
            cell.setup(movie: homeViewMode.popularMovie.value[indexPath.row])
            return cell
        case playingNowCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayingNowCollectionViewCell.identifier, for: indexPath) as! PlayingNowCollectionViewCell
            cell.setup(movie: homeViewMode.playingMovie.value[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  collectionView == playingNowCollectionView {
            let controller = DetailMovieViewController.instantiate()
//            controller.movie = homeViewMode.playingMovie.value[indexPath.row]
            let detailProtocol = Injection.init().provideDetail(movie: homeViewMode.playingMovie.value[indexPath.row])
            controller.detailViewModel = DetailViewModel(detailInteractor: detailProtocol)
            navigationController?.pushViewController(controller, animated: true)
        } else if collectionView == trendingCollectionView {
            let controller = DetailMovieViewController.instantiate()
            let detailProtocol = Injection.init().provideDetail(movie: homeViewMode.popularMovie.value[indexPath.row])
            controller.detailViewModel = DetailViewModel(detailInteractor: detailProtocol)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    
    
    
}

