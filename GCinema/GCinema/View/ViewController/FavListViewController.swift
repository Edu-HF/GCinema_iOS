//
//  FavListViewController.swift
//  GCinema
//
//  Created by Edu on 03/03/21.
//

import UIKit

class FavListViewController: UIViewController {

    @IBOutlet weak var mFavListTV: UITableView!
    private var mUPresenter: UserPresenter?
    private var mPresenter: MainPresenter?
    private var mFavMovieList: [Movie] = []
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mUPresenter?.getUserFavList()
    }
    
    override func onUserMenuTag() {
        self.goToUserMenu()
    }
    
    //MARK: Private Methods
    private func setupUI() {
        
        self.mUPresenter = UserPresenter(viewIn: self)
        self.mPresenter = MainPresenter(viewIn: self)
        self.buildUserMenuBtn(colorIn: .orangeColor)
        self.mFavListTV.register(UINib(nibName: "FavCell", bundle: nil), forCellReuseIdentifier: "FavCell")
        self.mFavListTV.rowHeight = UITableView.automaticDimension
        self.setupSearchBar()
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

//MARK: Extension UITableView Delegate Methods
extension FavListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mFavMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favCell = tableView.dequeueReusableCell(withIdentifier: "FavCell") as! FavCell
        favCell.setupCell(movieIn: self.mFavMovieList[indexPath.row])
        
        return favCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mPresenter?.setMovieSelected(movieIn: self.mFavMovieList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let mDeleteBtn = UIContextualAction.init(style: .destructive, title: "") { _, _, _ in
            var mMovie = self.mFavMovieList[indexPath.row]
            mMovie.isFav = false
            self.mUPresenter?.updateFav(favIn: mMovie)
            self.mFavMovieList.remove(at: indexPath.row)
            self.mFavListTV.reloadData()
        }
        mDeleteBtn.backgroundColor = .swipeBGColor
        mDeleteBtn.image = UIImage(named: "Delete_IC")
        
        return UISwipeActionsConfiguration(actions: [mDeleteBtn])
    }
}


//MARK: Extension SearchBar Delegate Methods
extension FavListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.mFavMovieList = []
        self.mFavListTV.reloadData()
        self.mUPresenter?.getSearchFavMovieList(queryIn: searchText)
    }
}

//MARK: Extension Protocols Methods
extension FavListViewController: UserViewProtocol {
    
    func onUserAccess() {}
    
    func onFavListRetrieval(movieListIn: [Movie]) {
        self.removeLoading()
        self.mFavMovieList = movieListIn
        self.mFavListTV.reloadData()
    }
    
    func onMSGRetrieval(msgIn: String) {
        self.removeLoading()
        self.showAlertWithActions(titleIn: "Attention", msgIn: msgIn, actionsIn: nil)
    }
}

extension FavListViewController: MovieListViewProtocol {
    
    func onMovieListRetrieval(movieListIn: [Movie]) {}
    
    func onMovieSelected(movieIn: Movie?) {
        
        self.removeLoading()
        let movieDetailVC = MovieDetailViewController()
        movieDetailVC.mMovieSelected = movieIn
        self.present(movieDetailVC, animated: true, completion: nil)
    }
}
