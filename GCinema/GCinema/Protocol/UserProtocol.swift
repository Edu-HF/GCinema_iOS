//
//  UserProtocol.swift
//  GCinema
//
//  Created by Edu on 08/03/21.
//

import Foundation

//MARK: View Protocols
//MARK: User View Protocol
protocol UserViewProtocol: ViewBaseProtocol {
    
    func onUserAccess()
    func onFavListRetrieval(movieListIn: [Movie])
}

//MARK: Presenter Protocols
//MARK: User Presenter Protocol
protocol UserPresenterProtocol: class {
    
    init(viewIn: UserViewProtocol)
    func getUserFavList()
    func updateFav(favIn: Movie?)
    func makeLogin(emailIn: String?, passIn: String?)
    func makeSignIn(nameIn: String?, emailIn: String?, passIn: String?)
    
}
