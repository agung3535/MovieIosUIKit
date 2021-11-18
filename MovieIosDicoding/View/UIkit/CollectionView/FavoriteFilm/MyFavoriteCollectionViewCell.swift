//
//  MyFavoriteCollectionViewCell.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import UIKit
import SDWebImage
class MyFavoriteCollectionViewCell: UICollectionViewCell {

    static let identifier = "MyFavoriteCollectionViewCell"
    @IBOutlet weak var movieLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    func setup(favorite: MovieModel) {
        movieLbl.text = favorite.title
        ratingLbl.text = favorite.voteAverage
        imgMovie.sd_setImage(with: String(Route.imageUrl + favorite.backdropPath).asUrl)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
