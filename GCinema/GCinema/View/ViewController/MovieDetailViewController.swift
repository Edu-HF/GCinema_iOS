//
//  MovieDetailViewController.swift
//  GCinema
//
//  Created by Edu on 04/03/21.
//

import UIKit
import Nuke
import Cosmos

class MovieDetailViewController: UIViewController {
    
    //MARK: Outlets and Vars
    @IBOutlet weak var mBGImage: UIImageView!
    @IBOutlet weak var mBGView: UIView!
    @IBOutlet weak var mTitleLB: UILabel!
    @IBOutlet weak var mGenresLB: UILabel!
    @IBOutlet weak var mMoreBtn: UIButton!
    @IBOutlet weak var mSinoxisTV: UITextView!
    @IBOutlet weak var mCastCV: UICollectionView!
    @IBOutlet weak var mInfoViewBC: NSLayoutConstraint!
    @IBOutlet weak var mRankingView: CosmosView!
    @IBOutlet weak var mFavBtn: UIButton!
    
    var mMovieSelected: Movie?
    
    private var isShowMore: Bool = false
    private var mUPresenter: UserPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: Private Methods
    private func setupUI() {
        
        self.mUPresenter = UserPresenter(viewIn: self)
        self.mCastCV.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
        self.mBGView.addVerticalGradient(colorBottomIn: .blackColor)
        self.setUIInfo()
        self.mUPresenter?.getUserFavList()
    }
    
    private func setUIInfo() {
        
        mRankingView.rating = (self.mMovieSelected?.mRanking ?? 0) / 2
        if let imgURL = URL(string: self.mMovieSelected?.mPoster?.buildURLStringIMG() ?? "") {
            Nuke.loadImage(with: imgURL, options: ImageLoadingOptions(
                placeholder: UIImage(named: "Collage_IC"),
                transition: .fadeIn(duration: 0.30)
            ), into: self.mBGImage)
        }
        
        var genres: String = ""
        self.mMovieSelected?.mGenreList?.forEach{ genreIn in
            genres += genreIn.mName ?? ""
            genres += " "
        }
        
        self.mTitleLB.text = self.mMovieSelected?.mTitle
        self.mGenresLB.text = genres
        self.mSinoxisTV.text = self.mMovieSelected?.mOverview
        
        self.mMovieSelected?.isFav ?? false ? self.mFavBtn.setImage(UIImage(named: "Fav_IC"), for: .normal) : self.mFavBtn.setImage(UIImage(named: "FavOff_IC"), for: .normal)
    }
    
    private func showCastSelectedView(castIn: Cast?) {
        
        let castDetailView = CastDetailView.instanceFromNib()
        castDetailView.setupUI(castIn: castIn)
        self.view.addSubview(castDetailView)
        castDetailView.animationSlideInVertical(delay: 0.5, direction: .Bottom, block: {})
    
    }
    
    //MARK: Action Methods
    @IBAction func onMoreTouch(_ sender: Any) {
        
        if self.isShowMore {
            
            self.isShowMore = false
            self.mMoreBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)

            self.mInfoViewBC.constant = -300
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            
        }else{
            
            self.isShowMore = true
            self.mMoreBtn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            
            self.mInfoViewBC.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func onPlayTouch(_ sender: Any) {
        
    }
    
    @IBAction func onFavTouch(_ sender: Any) {
        
        if self.mUPresenter?.isUserLogin() ?? false {
            if !(self.mMovieSelected?.isFav ?? false) {
                self.mMovieSelected?.isFav = true
                self.mFavBtn.setImage(UIImage(named: "Fav_IC"), for: .normal)
            }else{
                self.mMovieSelected?.isFav = false
                self.mFavBtn.setImage(UIImage(named: "FavOff_IC"), for: .normal)
            }
            
            self.mUPresenter?.updateFav(favIn: self.mMovieSelected)
        }else{
            self.present(LoginViewController(), animated: true, completion: nil)
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mMovieSelected?.mCastList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        mCell.setupCell(castIn: self.mMovieSelected?.mCastList?[indexPath.row])
        
        return mCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showCastSelectedView(castIn: self.mMovieSelected?.mCastList?[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 120)
    }
}
 
extension MovieDetailViewController: UserViewProtocol {
    
    func onUserAccess() {}
    
    func onFavListRetrieval(movieListIn: [Movie]) {
        
        movieListIn.forEach { movieIn in
            if self.mMovieSelected?.mID == movieIn.mID {
                self.mMovieSelected = movieIn
                self.setUIInfo()
            }
        }
    }
    
    func onMSGRetrieval(msgIn: String) {
        self.removeLoading()
        self.showAlertWithActions(titleIn: "Attention", msgIn: msgIn, actionsIn: nil)
    }
}

