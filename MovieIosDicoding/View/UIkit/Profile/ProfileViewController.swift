//
//  ProfileViewController.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import UIKit
import Combine
class ProfileViewController: UIViewController {

    
    @IBOutlet weak var emptyFav: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var favoriteCollection: UICollectionView!
    var subscriptions = Set<AnyCancellable>()
    private let profileViewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollection.delegate = self
        favoriteCollection.dataSource = self
        // Do any additional setup after loading the view.
        registerCell()
        self.title = ""
        userProfile.layer.masksToBounds = true
        userProfile.layer.cornerRadius = userProfile.bounds.width / 2.5
//        profileViewModel.hasFavorite.sink {[weak self] (res) in
//            if res {
//                self?.emptyFav.isHidden = true
//                self?.favoriteCollection.isHidden = false
//            } else {
//                self?.emptyFav.isHidden = false
//                self?.favoriteCollection.isHidden = true
//            }
//        }.store(in: &subscriptions)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
        print("home data dipanggil")
        
    }
    func getData() {
        print("get data dipanggil")
        profileViewModel.getFavorite()
        profileViewModel.favMovie.sink {[weak self] (_) in
            self?.favoriteCollection.reloadData()
        }.store(in: &subscriptions)
        print("size favorite = \(profileViewModel.favMovie.value.count)")
    }
    
    func registerCell() {
        favoriteCollection.register(UINib(nibName: MyFavoriteCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyFavoriteCollectionViewCell.identifier)
    }

}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileViewModel.favMovie.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFavoriteCollectionViewCell.identifier, for: indexPath) as! MyFavoriteCollectionViewCell
        cell.setup(favorite: profileViewModel.favMovie.value[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  collectionView == favoriteCollection {
           
            let controller = DetailMovieViewController.instantiate()
            let detailProtocol = Injection.init().provideDetail(movie: profileViewModel.favMovie.value[indexPath.row])
            controller.detailViewModel = DetailViewModel(detailInteractor: detailProtocol)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}




