//
//  SplashViewController.swift
//  GCinema
//
//  Created by Edu on 07/03/21.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    private let mAnimView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.playSplashAnim()
    }
    
    //MARK: Private Methods
    private func setupUI() {
        
        self.view.backgroundColor = .baseAppColor
        let splashAnim = Animation.named("GCinema_Intro_Anim")
        self.mAnimView.animation = splashAnim
        self.mAnimView.frame = CGRect(origin: self.view.frame.origin, size: CGSize(width: 300, height: 300))
        self.mAnimView.center = self.view.center
        self.mAnimView.contentMode = .scaleAspectFit
        self.view.addSubview(mAnimView)
    }
    
    private func playSplashAnim() {
        
        self.mAnimView.play { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
