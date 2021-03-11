//
//  LoginViewController.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

import UIKit
import Firebase

private enum LoginFlow {
    case LOGIN, SIGNIN
}

class LoginViewController: UIViewController {

    //MARK: Outlets and vars
    @IBOutlet weak var mBGImage: UIImageView!
    @IBOutlet weak var mBGView: UIView!
    @IBOutlet weak var mNameTF: UITextField!
    @IBOutlet weak var mEmailTF: UITextField!
    @IBOutlet weak var mPassTF: UITextField!
    @IBOutlet weak var mLogInBtn: UIButton!
    @IBOutlet weak var mAppleBtn: UIButton!
    @IBOutlet weak var mForgotPassBtn: UIButton!
    @IBOutlet weak var mFlowBtn: UIButton!
    @IBOutlet weak var mBGViewC: NSLayoutConstraint!
    
    private var mFlow: LoginFlow = .LOGIN
    private var mPresenter: UserPresenterProtocol?
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.makeAnimations()
    }
    
    //MARK: Private Methods
    private func setupUI() {
        
        self.mPresenter = UserPresenter(viewIn: self)
        self.mBGView.addVBorder(cornersIn: [.topLeft], radiusIn: 80)
        self.mNameTF.overrideUserInterfaceStyle = .light;
        self.mEmailTF.overrideUserInterfaceStyle = .light;
        self.mPassTF.overrideUserInterfaceStyle = .light;
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyBoardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func makeAnimations() {
        
        self.mEmailTF.animationSlideInHorizontal(delay: 1.0, direction: .Left, block: {})
        self.mPassTF.animationSlideInHorizontal(delay: 1.0, direction: .Right, block: {})
        
        self.mLogInBtn.animationSlideInVertical(delay: 1.0, direction: .Bottom, block: {})
        self.mAppleBtn.animationSlideInVertical(delay: 1.0, direction: .Bottom, block: {})
    }
    
    private func makeLoginUIConfig() {
        
        self.mNameTF.animationFaceOut(alphaIn: 1.0)
        self.mFlowBtn.setTitle("Not have account?", for: .normal)
        self.mLogInBtn.setTitle("Log In", for: .normal)
        self.mForgotPassBtn.animationFaceIn(alphaIn: 1.0)
    }
    
    private func makeSignInUIConfig() {
        
        self.mNameTF.animationFaceIn(alphaIn: 1.0)
        self.mFlowBtn.setTitle("you have account?", for: .normal)
        self.mLogInBtn.setTitle("Sign In", for: .normal)
        self.mForgotPassBtn.animationFaceOut(alphaIn: 1.0)
    }
    
    private func validateFields() -> Bool {
        
        switch self.mFlow {
        case .LOGIN:
            if !self.mEmailTF.validateForKind(mTypeIn: .mEmail) || !self.mPassTF.validateForKind(mTypeIn: .mPass) {
                return false
            }
        case .SIGNIN:
            if !self.mNameTF.validateForKind(mTypeIn: .mNotNull) || !self.mEmailTF.validateForKind(mTypeIn: .mEmail) || !self.mPassTF.validateForKind(mTypeIn: .mPass) {
                return false
            }
        }
        
        return true
    }

    // MARK: Action Methods
    @objc private func onKeyBoardShow() {
        
        self.mBGViewC.constant = 600
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func onKeyBoardHide() {
       
        self.mBGViewC.constant = 350
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func onFlowBtnTag(_ sender: Any) {
        
        switch self.mFlow {
        case .LOGIN:
            self.mFlow = .SIGNIN
            self.makeSignInUIConfig()
        case .SIGNIN:
            self.mFlow = .LOGIN
            self.makeLoginUIConfig()
        }
    }
    
    @IBAction func onForgotPassTag(_ sender: Any) {
        
    }
    
    @IBAction func onLoginBtnTag(_ sender: Any) {
        
        if self.validateFields() {
            self.showLoading()
            switch self.mFlow {
            case .LOGIN:
                self.mPresenter?.makeLogin(emailIn: self.mEmailTF.text, passIn: self.mPassTF.text)
            case .SIGNIN:
                self.mPresenter?.makeSignIn(nameIn: self.mNameTF.text, emailIn: self.mEmailTF.text, passIn: self.mPassTF.text)
            }
        }
    }
    
    @IBAction func onAppleBtnTag(_ sender: Any) {
    }
}

extension LoginViewController: UserViewProtocol {
    
    func onUserAccess() {
        self.removeLoading()
        self.dismiss(animated: true, completion: nil)
    }
    
    func onFavListRetrieval(movieListIn: [Movie]) {
        self.removeLoading()
        return
    }
    
    func onMSGRetrieval(msgIn: String) {
        self.removeLoading()
        self.showAlertWithActions(titleIn: "Attention", msgIn: msgIn, actionsIn: nil)
    }
}
