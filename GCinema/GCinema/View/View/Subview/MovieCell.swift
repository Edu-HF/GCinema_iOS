//
//  MovieCell.swift
//  GCinema
//
//  Created by Edu on 03/03/21.
//

import UIKit
import Nuke

class MovieCell: UICollectionViewCell {

    //MARK: Outlets and vars
    @IBOutlet weak var mMovieIMG: UIImageView!
    private var mMovie: Movie?
    
    private let mNukeOp = ImageLoadingOptions(
        placeholder: UIImage(systemName: "play.tv.fill"),
        transition: .fadeIn(duration: 0.30)
    )
    
    //MARK: Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.mMovieIMG.image = UIImage(systemName: "play.tv.fill")
    }

    //MARK: Public Methods
    func setupCell(movieIn: Movie?) {
        
        self.mMovie = movieIn
        
        if let imgURL = URL(string: self.mMovie?.mPoster?.buildURLStringIMG() ?? "") {
            Nuke.loadImage(with: imgURL, options: self.mNukeOp, into: self.mMovieIMG)
        }
    }
}
