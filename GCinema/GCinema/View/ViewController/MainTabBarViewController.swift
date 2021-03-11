//
//  MainTabBarViewController.swift
//  GCinema
//
//  Created by Edu on 09/03/21.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }

    //MARK: Private Methods
    private func setupTabBar() {
        self.delegate = self
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let mIndex = tabBar.items?.firstIndex(of: item) else { return }
        
        if mIndex == 1 {
            let mUPresenter = UserPresenter(viewIn: self)
            if !mUPresenter.isUserLogin() {
                self.present(LoginViewController(), animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                    if let mFirtItem = self.tabBar.items?[0] {
                        self.makeNavTo(itemIn: mFirtItem)
                    }
                })
            }
        }
    }
}

extension MainTabBarViewController: UserViewProtocol {
    
    func onUserAccess() {}
    
    func onFavListRetrieval(movieListIn: [Movie]) {}
    
    func onMSGRetrieval(msgIn: String) {
        self.removeLoading()
        self.showAlertWithActions(titleIn: "Attention", msgIn: msgIn, actionsIn: nil)
    }
    
}

extension UITabBarController {
    
    func makeNavTo(itemIn: UITabBarItem) {
        
        guard let mIndex = tabBar.items?.firstIndex(of: itemIn) else { return }
        if mIndex != selectedIndex, let mController = viewControllers?[mIndex] {
            selectedIndex = mIndex
            delegate?.tabBarController?(self, didSelect: mController)
        }
    }
}
 
