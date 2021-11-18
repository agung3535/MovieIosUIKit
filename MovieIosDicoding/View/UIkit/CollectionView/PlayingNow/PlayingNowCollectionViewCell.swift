//
//  PlayingNowCollectionViewCell.swift
//  MovieIosDicoding
//
//  Created by Putra on 16/11/21.
//

import UIKit
import SDWebImage
class PlayingNowCollectionViewCell: UICollectionViewCell {

    static let identifier = "PlayingNowCollectionViewCell"
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var rateMovie: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    func setup(movie: MovieModel) {
        titleMovie.text = movie.title
        imgMovie.sd_setImage(with: String(Route.imageUrl + movie.backdropPath).asUrl)
        rateMovie.text = movie.voteAverage

    }
}
