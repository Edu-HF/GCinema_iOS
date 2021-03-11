//
//  ExUIViewController.swift
//  GCinema
//
//  Created by Edu on 06/03/21.
//

import Foundation
import UIKit
import Lottie

extension UIViewController {
    
    func presentVC(viewControllerIn: UIViewController, modalIn: UIModalPresentationStyle = .overCurrentContext, transition: UIModalTransitionStyle = .coverVertical) {
        viewControllerIn.modalPresentationStyle = modalIn
        viewControllerIn.modalTransitionStyle = transition
        self.present(viewControllerIn, animated: true, completion: nil)
    }
    
    func presentVCWithNav(viewControllerIn: UIViewController) {
        viewControllerIn.overrideUserInterfaceStyle = .light
        if self.navigationController != nil {
            self.navigationController?.pushViewController(viewControllerIn, animated: true)
        }else{
            let navController = UINavigationController()
            navController.addChild(viewControllerIn)
            navController.modalPresentationStyle = .overCurrentContext
            navController.modalTransitionStyle = .crossDissolve
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    func backViewController() {
        
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
            if(self.navigationController?.viewControllers.count == 1){
                self.dismiss(animated: true, completion: {})
            }
        }else{
            self.dismiss(animated: true, completion: {})
        }
    }
    
    func backViewToRootController() {
        
        if self.navigationController != nil {
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: {})
        }
    }
    
    func buildBackNavBtn(colorIn: UIColor? = .black) {
        
        let image = UIImage(systemName: "chevron.left")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(goToBack))
        self.navigationItem.leftBarButtonItem?.tintColor = colorIn
    }
    
    func buildUserMenuBtn(colorIn: UIColor? = .black) {
        
        let mBtn = UIButton(type: .custom)
        mBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        mBtn.setImage(UIImage(named: "Cast_IC"), for: .normal)
        mBtn.addTarget(self, action: #selector(onUserMenuTag), for: .touchUpInside)
        let mUserBtn = UIBarButtonItem(customView: mBtn)
        let currW = mUserBtn.customView?.widthAnchor.constraint(equalToConstant: 25)
        currW?.isActive = true
        let currH = mUserBtn.customView?.heightAnchor.constraint(equalToConstant: 25)
        currH?.isActive = true
        self.navigationItem.rightBarButtonItem = mUserBtn
        self.navigationItem.leftBarButtonItem?.tintColor = colorIn
    }
    
    func buildLogOutBtn(colorIn: UIColor? = .black) {
        
        let mBtn = UIButton(type: .custom)
        mBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        mBtn.setImage(UIImage(named: "LogOut_IC"), for: .normal)
        mBtn.addTarget(self, action: #selector(onLogOutTag), for: .touchUpInside)
        let mUserBtn = UIBarButtonItem(customView: mBtn)
        let currW = mUserBtn.customView?.widthAnchor.constraint(equalToConstant: 25)
        currW?.isActive = true
        let currH = mUserBtn.customView?.heightAnchor.constraint(equalToConstant: 25)
        currH?.isActive = true
        self.navigationItem.rightBarButtonItem = mUserBtn
        self.navigationItem.leftBarButtonItem?.tintColor = colorIn
    }
    
    
    @objc func onUserMenuTag() {
        
    }
    
    @objc func onLogOutTag() {
        
    }
    
    @objc func goToBack() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
        self.backViewController()
    }
    
    func showLoading() {
        
        UIApplication.shared.windows.first?.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        let mBGView = UIView.init(frame: CGRect(x: self.view.center.x - 80, y: self.view.center.y - 80, width: 160, height: 160))
        mBGView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        mBGView.layer.cornerRadius = 20
        mBGView.tag = 909
        let mLoadingView = AnimationView()
        mLoadingView.animation = Animation.named("Loading_Anim")
        mLoadingView.frame = CGRect(x: 30, y: 30, width: 100, height: 100)
        mLoadingView.loopMode = .loop
        mLoadingView.play()
        mBGView.addSubview(mLoadingView)
        self.view.addSubview(mBGView)
    }
    
    func removeLoading() {
        
        UIApplication.shared.windows.first?.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true
        self.view.subviews.forEach { viewIn in
            if viewIn.tag == 909 {
                viewIn.removeFromSuperview()
            }
        }
    }
    
    func showAlertWithActions(titleIn: String, msgIn: String, actionsIn: [UIAlertAction]?) {
        
        DispatchQueue.main.async {
            let mAlert = UIAlertController(title: titleIn, message: msgIn, preferredStyle: .alert)
            
            if let actions = actionsIn {
                actions.forEach { (actionIn) in
                    mAlert.addAction(actionIn)
                }
            }else{
                mAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    mAlert.dismiss(animated: true, completion: nil)
                }))
            }
            
            self.present(mAlert, animated: true, completion: nil)
        }
    }
    
    func forceNavTabBar(itemIn: Int) {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
        if let mTBar = self.tabBarController?.tabBar {
            if let mFirtItem = mTBar.items?[0] {
                self.tabBarController?.makeNavTo(itemIn: mFirtItem)
            }
        }
    }
}
