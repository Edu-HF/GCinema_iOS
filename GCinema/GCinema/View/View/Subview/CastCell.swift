//
//  CastCell.swift
//  GCinema
//
//  Created by Edu on 04/03/21.
//

import UIKit
import Nuke

class CastCell: UICollectionViewCell {

    //MARK: Outlets and vars
    @IBOutlet weak var profileIMG: UIImageView!
    private var mCast: Cast?
    
    private let mNukeOp = ImageLoadingOptions(
        placeholder: UIImage(named: "Cast_IC"),
        transition: .fadeIn(duration: 0.30)
    )
    
    //MARK: Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.profileIMG.image = UIImage(named: "Cast_IC")
    }

    //MARK: Public Methods
    func setupCell(castIn: Cast?) {
        
        self.mCast = castIn
        
        if let imgURL = URL(string: self.mCast?.cProfilePath?.buildURLStringIMG() ?? "") {
            Nuke.loadImage(with: imgURL, options: self.mNukeOp, into: self.profileIMG)
        }
    }
}
