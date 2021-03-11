//
//  MainPresenter.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

import Foundation

class MainPresenter: NSObject, MovieListPresenterProtocol {
    
    //MARK: Vars and Properties
    private weak var mainView: MovieListViewProtocol?
    private var mainService: MainService? = MainService()
    private var mMovieList: [Movie] = []
    private var mFavMovieList: [Movie] = []
    private var mGenreList: [Genre] = []
    private var mMovieSelected: Movie?
    
    //MARK: Life Cycle Methods
    required init(viewIn: MovieListViewProtocol) {
        self.mainView = viewIn
    }
    
    //MARK: Private Methods
    private func getGenreList() {
        
        self.mainService?.getGenreList().done { responseIn in
            
            if let mGenreList = responseIn.mGenreList {
                self.mGenreList = mGenreList
            }
        
        }.catch { errorIn in
            self.mainView?.onMSGRetrieval(msgIn: errorIn.localizedDescription)
        }
    }
    
    func getCastList() {
        
        guard let mMovie = self.mMovieSelected else { return }
        
        
        self.mainService?.getCastList(movieIn: mMovie).done { responseIn in
            
            if let mCastList = responseIn.castList {
                self.mMovieSelected?.mCastList = mCastList
                self.mainView?.onMovieSelected(movieIn: self.mMovieSelected)
            }
        
        }.catch { errorIn in
            self.mainView?.onMSGRetrieval(msgIn: errorIn.localizedDescription)
        }
    }
    
    private func checkMovieGenreList() {
        
        self.mMovieSelected?.mGenreList = []
        self.mMovieSelected?.mGenreListID?.forEach { idIn in
            self.mGenreList.forEach { genreIn in
                if idIn == genreIn.mID {
                    self.mMovieSelected?.mGenreList?.append(genreIn)
                }
            }
        }
    }
    
    //MARK: Protocols Methods
    func getMovieList(pageIn: Int?) {
        
        self.getGenreList()
        self.mainService?.getMovieList(pageIn: pageIn).done { responseIn in
            
            if let movieList = responseIn.movieList {
                self.mMovieList = movieList
                self.mainView?.onMovieListRetrieval(movieListIn: self.mMovieList)
            }
        
        }.catch { errorIn in
            self.mainView?.onMSGRetrieval(msgIn: errorIn.localizedDescription)
        }
    }
    
    func getSearchMovieList(pageIn: Int?, queryIn: String?) {
        
        guard let mQuery = queryIn else { return }
        self.mainService?.getSearchMovieList(pageIn: pageIn, queryIn: mQuery).done { responseIn in
            
            if let movieList = responseIn.movieList {
                self.mMovieList = movieList
                self.mainView?.onMovieListRetrieval(movieListIn: self.mMovieList)
            }
        
        }.catch { errorIn in
            self.mainView?.onMSGRetrieval(msgIn: errorIn.localizedDescription)
        }
    }
    
    func setMovieSelected(movieIn: Movie?) {
        self.mMovieSelected = movieIn
        self.checkMovieGenreList()
        self.getCastList()
    }
}
