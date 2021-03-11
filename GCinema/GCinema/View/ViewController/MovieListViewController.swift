//
//  MovieListViewController.swift
//  GCinema
//
//  Created by Edu on 03/03/21.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var mMovieListCV: UICollectionView!
    private var mPresenter: MovieListPresenterProtocol?
    private lazy var mMovieList: [Movie] = []
    private lazy var currentItem: Int = 1
    private lazy var isLoadingMoreData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func onUserMenuTag() {
        self.goToUserMenu()
    }
    
    //MARK: Private Methods
    private func setupUI() {
        
        self.mPresenter = MainPresenter(viewIn: self)
        self.buildUserMenuBtn(colorIn: .orangeColor)
        self.mMovieListCV.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        self.setupSearchBar()
        self.mPresenter?.getMovieList(pageIn: self.currentItem)
        
        //MARK: Splash View
        let mSView = SplashViewController()
        mSView.modalPresentationStyle = .fullScreen
        self.present(mSView, animated: false, completion: nil)
    }
    
    private func setupSearchBar() {
        
        let searchC = UISearchController(searchResultsController: nil)
        searchC.searchBar.delegate = self
        self.navigationItem.searchController = searchC
    }
    
    private func goToUserMenu() {
        
        let mUPresenter = UserPresenter(viewIn: self)
        if mUPresenter.isUserLogin() {
            self.presentVCWithNav(viewControllerIn: UserMenuViewController())
        }else{
            self.present(LoginViewController(), animated: true, completion: nil)
        }
    }
}

//MARK: Extension UICollectionView Methods
extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        mCell.setupCell(movieIn: self.mMovieList[indexPath.row])
        
        return mCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.mPresenter?.setMovieSelected(movieIn: self.mMovieList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if !self.isLoadingMoreData && indexPath.row == self.mMovieList.count - 1 {
            self.isLoadingMoreData = true
            self.currentItem += 1
            self.showLoading()
            self.mPresenter?.getMovieList(pageIn: currentItem)
        }
    }
}

//MARK: Extension SearchBar Delegate Methods
extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.mMovieList = []
        self.mPresenter?.getSearchMovieList(pageIn: nil, queryIn: searchText)
    }
}

//MARK: Extension Protocols Methods
extension MovieListViewController: MovieListViewProtocol {
    
    func onMovieListRetrieval(movieListIn: [Movie]) {
        
        self.removeLoading()
        self.isLoadingMoreData = false
        movieListIn.forEach { movieIn in
            self.mMovieList.append(movieIn)
        }
        self.mMovieListCV.reloadData()
    }
    
    func onMovieSelected(movieIn: Movie?) {
        
        self.removeLoading()
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.mMovieSelected = movieIn
        self.present(movieDetailVC, animated: true, completion: nil)
    }
    
    func onMSGRetrieval(msgIn: String) {
        self.removeLoading()
        self.showAlertWithActions(titleIn: "Attention", msgIn: msgIn, actionsIn: nil)
    }
}

extension MovieListViewController: UserViewProtocol {
    
    func onFavListRetrieval(movieListIn: [Movie]) {}
    
    func onUserAccess() {}
}
