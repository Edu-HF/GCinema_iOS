//
//  MainProtocol.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

import Foundation

//MARK: View Protocols
//MARK: Movie List View Protocol
protocol ViewBaseProtocol: class {
    func onMSGRetrieval(msgIn: String)
}

protocol MovieListViewProtocol: ViewBaseProtocol {
    
    func onMovieListRetrieval(movieListIn: [Movie])
    func onMovieSelected(movieIn: Movie?)
}

//MARK: Presenter Protocols
//MARK: Movie List Presenter Protocol
protocol MovieListPresenterProtocol: class {
    
    init(viewIn: MovieListViewProtocol)
    func getMovieList(pageIn: Int?)
    func getSearchMovieList(pageIn: Int?, queryIn: String?)
    func setMovieSelected(movieIn: Movie?)
}
