//
//  CastDetailView.swift
//  GCinema
//
//  Created by Edu on 07/03/21.
//

import UIKit
import Nuke

class CastDetailView: UIView {

    //MARK: Outlets and vars
    @IBOutlet weak var castIMG: UIImageView!
    @IBOutlet weak var castNameLB: UILabel!
    @IBOutlet weak var castDepartmentLB: UILabel!
    @IBOutlet weak var castCharacterLB: UILabel!
    
    private let mNukeOp = ImageLoadingOptions(
        placeholder: UIImage(systemName: "Cast_IC"),
        transition: .fadeIn(duration: 0.30)
    )
    
    //MARK: Life Cycle Methods
    class func instanceFromNib() -> CastDetailView {
        return UINib(nibName: "CastDetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CastDetailView
    }
    
    override func awakeFromNib() {
        
    }
    
    //MARK: Public Methods
    func setupUI(castIn: Cast?) {
        
        self.center = UIApplication.shared.windows.first?.center ?? CGPoint()
        
        if let imgURL = URL(string: castIn?.cProfilePath?.buildURLStringIMG() ?? "") {
            Nuke.loadImage(with: imgURL, options: self.mNukeOp, into: self.castIMG)
        }
        
        self.castNameLB.text = castIn?.cRealName
        self.castDepartmentLB.text = castIn?.cDepartment
        self.castCharacterLB.text = castIn?.cCharacter
    }
    
    @IBAction func onAcceptTag(_ sender: Any) {
        self.removeFromSuperview()
    }
}
