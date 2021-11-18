//
//  DetailMovieViewController.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import UIKit
import Combine
class DetailMovieViewController: UIViewController {

    
    
    
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var watchTotal: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var posterMovie: UIImageView!
    var subscriptions = Set<AnyCancellable>()
    var detailViewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detailViewModel.movie.sink { [weak self] (data) in
            self?.movieRate.text = String(data.voteAverage)
            self?.posterMovie.sd_setImage(with: String(Route.imageUrl + data.backdropPath).asUrl)
            self?.movieTitle.text = data.title
            self?.overviewLbl.text = data.overview
            self?.watchTotal.text = String(data.popularity)
        }.store(in: &subscriptions)
        detailViewModel.cekFavorite(movie: detailViewModel.movie.value)
        detailViewModel.isFavorite.sink{ [weak self] (fav) in
            if fav {
                print("fav is =\(fav)")
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .thin, scale: .small)
                self?.favBtn.setImage(UIImage(systemName: "heart.fill", withConfiguration: largeConfig), for: .normal)
            }else {
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin, scale: .small)
                self?.favBtn.setImage(UIImage(systemName: "heart", withConfiguration: largeConfig), for: .normal)
            }
        }.store(in: &subscriptions)
    }
    
    
    

    @IBAction func addFavorite(_ sender: Any) {
        print("value fav tanpa sink = \(detailViewModel.isFavorite.value)")
            if detailViewModel.isFavorite.value {
                print("Masuk delete")
                self.detailViewModel.deleteFavorite(movie: detailViewModel.movie.value)
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .thin, scale: .small)
                self.favBtn.setImage(UIImage(systemName: "heart.fill", withConfiguration: largeConfig), for: .normal)
            }else {
                print("masuk else fav ")
                self.detailViewModel.setFavorite(movie: detailViewModel.movie.value)
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin, scale: .small)
                self.favBtn.setImage(UIImage(systemName: "heart", withConfiguration: largeConfig), for: .normal)
            }
        
    
    }
}
