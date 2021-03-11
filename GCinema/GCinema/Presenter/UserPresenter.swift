//
//  UserPresenter.swift
//  GCinema
//
//  Created by Edu on 08/03/21.
//

import Foundation
import Firebase

class UserPresenter: NSObject, UserPresenterProtocol {
    
    //MARK: Vars and Properties
    private weak var mainView: UserViewProtocol?
    private var mainService: MainService? = MainService()
    private var mDBReference = Database.database().reference()
    private var mainUser: User?
    
    //MARK: Life Cycle Methods
    required init(viewIn: UserViewProtocol) {
        self.mainView = viewIn
    }
    
    //MARK: Public Methods
    func isUserLogin() -> Bool {
        return self.getUser() != nil
    }
    
    func getUser() -> User? {
        
        let uDefaults = UserDefaults.standard
        guard let userData = uDefaults.object(forKey: GKeys.USER_DATA_KEY) as? Data else {
            return nil
        }
        
        guard let rUser = try? PropertyListDecoder().decode(User.self, from: userData) else {
            return nil
        }
                
        return rUser
    }
    
    func logOut() -> Bool {
        UserDefaults.standard.removeObject(forKey: GKeys.USER_DATA_KEY)
        return !isUserLogin()
    }
    
    //MARK: Private Methods
    private func saveUser(userIn: User?) -> Bool {
        
        do {
            try UserDefaults.standard.set(PropertyListEncoder().encode(userIn), forKey: GKeys.USER_DATA_KEY)
        } catch {
            return false
        }
        
        self.mainUser = userIn
        return true
    }
    
    //MARK: Protocol Methods
    func makeLogin(emailIn: String?, passIn: String?) {
        
        guard let email = emailIn else { return }
        guard let pass = passIn else { return }
        
        Auth.auth().signIn(withEmail: email, password: pass) { (authResultIn, errorIn) in
            
            if let error = errorIn {
                self.mainView?.onMSGRetrieval(msgIn: error.localizedDescription)
                return
            }
            
            if let mFUser = authResultIn?.user {
                let mUser = User(uID: mFUser.uid, uName: mFUser.displayName, uEmail: mFUser.email, uFavMovieList: [])
                if self.saveUser(userIn: mUser) {
                    self.mainView?.onUserAccess()
                }else{
                    self.mainView?.onMSGRetrieval(msgIn: "")
                }
            }else{
                self.mainView?.onMSGRetrieval(msgIn: "")
            }
        }
    }
    
    func makeSignIn(nameIn: String?, emailIn: String?, passIn: String?) {
        
        guard let name = nameIn else { return }
        guard let email = emailIn else { return }
        guard let pass = passIn else { return }
        
        Auth.auth().createUser(withEmail: email, password: pass) { (authResultIn, errorIn) in
            
            if let error = errorIn {
                self.mainView?.onMSGRetrieval(msgIn: error.localizedDescription)
                return
            }
            
            if let mFUser = authResultIn?.user {
                let mCRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                mCRequest?.displayName = name
                mCRequest?.commitChanges(completion: { errorIn in
                    
                    if let error = errorIn {
                        self.mainView?.onMSGRetrieval(msgIn: error.localizedDescription)
                        return
                    }
                    
                    let mUser = User(uID: mFUser.uid, uName: name, uEmail: mFUser.email, uFavMovieList: [])
                    if self.saveUser(userIn: mUser) {
                        self.mainView?.onUserAccess()
                    }else{
                        self.mainView?.onMSGRetrieval(msgIn: "")
                    }
                })
            }else{
                self.mainView?.onMSGRetrieval(msgIn: "")
            }
        }
    }
    
    func getUserFavList() {
        
        guard let uID = self.getUser()?.uID else { return }
        
        self.mDBReference.child(GKeys.USER_FB_FAV_PATH_KEY + "\(uID)").observeSingleEvent(of: .value, with: { snapShotIn in
            
            var mFavList: [Movie] = []
            for mChild in snapShotIn.children {
                if let snap = mChild as? DataSnapshot {
                    if let mMovieAny = snap.value {
                        if let mMovie = self.makeAnyDecode(Movie.self, mMovieAny) {
                            mFavList.append(mMovie)
                        }
                    }
                }
            }
            
            self.mainView?.onFavListRetrieval(movieListIn: mFavList)
        })
    }
    
    func updateFav(favIn: Movie?) {
        
        guard let uID = self.getUser()?.uID else { return }
        guard let mMovie = favIn else { return }
        
        var mFavList: [[String : Any]] = []
        let mDBRef = self.mDBReference.child(GKeys.USER_FB_FAV_PATH_KEY).child("\(uID)")
        mDBRef.observeSingleEvent(of: .value, with: { snapShotIn in
            
            for mChild in snapShotIn.children {
                if let snap = mChild as? DataSnapshot {
                    if let mMovieAny = snap.value {
                        if let mMovie = mMovieAny as? [String : Any] {
                            mFavList.append(mMovie)
                        }
                    }
                }
            }
            
            if mMovie.isFav ?? false {
                if let mMovieDic = mMovie.toDictionary {
                    mFavList.append(mMovieDic)
                }
            }else{
                for (index, movieDic) in mFavList.enumerated() {
                    if let movie = self.makeAnyDecode(Movie.self, movieDic) {
                        if mMovie.mID == movie.mID {
                            mFavList.remove(at: index)
                        }
                    }
                }
            }
            
            mDBRef.setValue(mFavList)
            self.getUserFavList()
        })
    }
}
