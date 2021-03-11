//
//  UserMenuViewController.swift
//  GCinema
//
//  Created by Edu on 06/03/21.
//

import UIKit

class UserMenuViewController: UIViewController {


    @IBOutlet weak var userIMG: UIImageView!
    @IBOutlet weak var userNameLB: UILabel!
    @IBOutlet weak var userEmailLB: UILabel!
    @IBOutlet weak var appVersionLB: UILabel!
    @IBOutlet weak var mGView: UIView!
    
    private var mUPresenter: UserPresenter?
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.makeAnimations()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func onLogOutTag() {
        self.showLogOutAlert()
    }
    
    //MARK: Private Methods
    private func setupUI() {
        
        self.mUPresenter = UserPresenter(viewIn: self)
        self.mGView.addVerticalGradient(colorTopIn: .darkColor)
        self.buildBackNavBtn(colorIn: .orangeColor)
        self.buildLogOutBtn(colorIn: .orangeColor)
        self.tabBarController?.tabBar.isHidden = true
        self.setupUIInfo()
    
    }
    
    private func setupUIInfo() {
        
        guard let mUser = self.mUPresenter?.getUser() else { self.backViewController(); return }
        
        self.userNameLB.text = mUser.uName
        self.userEmailLB.text = mUser.uEmail
    }

    private func showLogOutAlert() {
        
        self.showAlertWithActions(titleIn: "Attention", msgIn: "Are you sure you want to log out?", actionsIn: [UIAlertAction.init(title: "Yes", style: .default, handler: { _ in
            if self.mUPresenter?.logOut() ?? false {
                self.goToBack()
                self.forceNavTabBar(itemIn: 0)
            }
        }), UIAlertAction.init(title: "No", style: .default, handler: nil)])
    }
}

extension UserMenuViewController: UserViewProtocol {
    
    func onUserAccess() {}
    
    func onFavListRetrieval(movieListIn: [Movie]) {}
    
    func onMSGRetrieval(msgIn: String) {
        self.removeLoading()
        self.showAlertWithActions(titleIn: "Attention", msgIn: msgIn, actionsIn: nil)
    }
}
