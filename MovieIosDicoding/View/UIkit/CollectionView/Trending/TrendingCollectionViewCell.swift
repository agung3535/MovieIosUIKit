//
//  TrendingCollectionViewCell.swift
//  MovieIosDicoding
//
//  Created by Putra on 16/11/21.
//

import UIKit
import SDWebImage

class TrendingCollectionViewCell: UICollectionViewCell {

    static let identifier = "TrendingCollectionViewCell"
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    
    func setup(movie: MovieModel) {
        movieNameLbl.text = movie.title
        posterImage.sd_setImage(with: String(Route.imageUrl + movie.backdropPath).asUrl)
        ratingLbl.text = String(movie.voteAverage)
        print("rating = \(movie.voteAverage)")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
        
        
    }
    
    

}
