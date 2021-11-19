//
//  ViewController.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import UIKit
import Combine
class HomeViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var playingNowCollectionView: UICollectionView!
    @IBOutlet weak var loadingPlaying: UIActivityIndicatorView!
    var homeViewModel: HomeViewModel?
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        playingNowCollectionView.delegate = self
        playingNowCollectionView.dataSource = self
        registerCell()
        
        
        callApi()
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view model isinya: \(homeViewModel)")
        homeViewModel?.popularMovie.sink{[weak self] (_) in
            self?.trendingCollectionView.reloadData()
        }.store(in: &subscriptions)
        homeViewModel?.playingMovie.sink{[weak self] (_) in
            self?.playingNowCollectionView.reloadData()
        }.store(in: &subscriptions)
        homeViewModel?.loadingTrendingState.sink{ [weak self] (loading) in
            if !loading {
                print("loading: \(loading)")
                self?.loadingView.isHidden = true
            }
        }.store(in: &subscriptions)

        homeViewModel?.loadingPlayingState.sink { [weak self] (loading) in
            if !loading {
                self?.loadingPlaying.isHidden = true
            }
        }.store(in: &subscriptions)
    }
    
    

    func registerCell(){

        trendingCollectionView.register(UINib(nibName: TrendingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        playingNowCollectionView.register(UINib(nibName: PlayingNowCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PlayingNowCollectionViewCell.identifier)
    }
    
    func callApi() {
        homeViewModel?.getPopularMovie()
        homeViewModel?.getPlayingNow()

    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case trendingCollectionView:
            print("masuk trending : \(homeViewModel?.popularMovie.value.count)")
            
            return homeViewModel?.popularMovie.value.count ?? 0
        case playingNowCollectionView:
            return homeViewModel?.playingMovie.value.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case trendingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
            cell.setup(movie: (homeViewModel?.popularMovie.value[indexPath.row])!)
            return cell
        case playingNowCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayingNowCollectionViewCell.identifier, for: indexPath) as! PlayingNowCollectionViewCell
            cell.setup(movie: (homeViewModel?.playingMovie.value[indexPath.row])!)
            return cell
        default:
            return UICollectionViewCell()
        }


    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  collectionView == playingNowCollectionView {
            let controller = DetailMovieViewController.instantiate()
//            controller.movie = homeViewMode.playingMovie.value[indexPath.row]
            let detailProtocol = Injection.init().provideDetail(movie: (homeViewModel?.playingMovie.value[indexPath.row])!)
            controller.detailViewModel = DetailViewModel(detailInteractor: detailProtocol)
            navigationController?.pushViewController(controller, animated: true)
        } else if collectionView == trendingCollectionView {
            let controller = DetailMovieViewController.instantiate()
            let detailProtocol = Injection.init().provideDetail(movie: (homeViewModel?.popularMovie.value[indexPath.row])!)
            controller.detailViewModel = DetailViewModel(detailInteractor: detailProtocol)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    

    
}

