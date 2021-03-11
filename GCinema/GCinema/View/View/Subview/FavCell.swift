//
//  FavCell.swift
//  GCinema
//
//  Created by Edu on 03/03/21.
//

import UIKit
import Nuke

class FavCell: UITableViewCell {

    //MARK: Outlets and vars
    @IBOutlet weak var mFavIMG: UIImageView!
    @IBOutlet weak var mFavTitleLB: UILabel!
    @IBOutlet weak var mFavOverviewLB: UILabel!
    @IBOutlet weak var mFavGeresLB: UILabel!
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
        
        self.mFavIMG.image = UIImage(systemName: "play.tv.fill")
        self.mFavTitleLB.text = ""
        self.mFavOverviewLB.text = ""
        self.mFavGeresLB.text = ""
    }

    //MARK: Public Methods
    func setupCell(movieIn: Movie?) {
        
        self.mMovie = movieIn

        var genres: String = ""
        self.mMovie?.mGenreList?.forEach{ genreIn in
            genres += genreIn.mName ?? ""
            genres += " "
        }
        
        self.mFavTitleLB.text = self.mMovie?.mTitle
        self.mFavOverviewLB.text = self.mMovie?.mOverview
        self.mFavGeresLB.text = genres
        
        if let imgURL = URL(string: self.mMovie?.mPoster?.buildURLStringIMG() ?? "") {
            Nuke.loadImage(with: imgURL, options: self.mNukeOp, into: self.mFavIMG)
        }
    }
}
