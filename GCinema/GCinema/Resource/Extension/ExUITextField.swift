//
//  ExUITextfield.swift
//  GCinema
//
//  Created by Edu on 08/03/21.
//

import Foundation
import UIKit

enum mTFType {
    case mPass, mEmail, mOnlyNum, mNotNull, mCPF, mDate, mPhone, mCEP, mNumberCard, mCvc
}

extension UITextField {
    
    @IBInspectable
    var isDoneBarEnable: Bool {
        get {
            return self.isDoneBarEnable
        }
        
        set (hasDone) {
            if hasDone {
                builDoneBtn()
            }
        }
    }
    
    func builDoneBtn() {
        
        let doneBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
        doneBar.barStyle = .default
        doneBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem.init(title: /*"DoneKey".localized()*/"Done", style: .done, target: self, action: #selector(doneButtonAction))]
        self.inputAccessoryView = doneBar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
    
    func validateForKind(mTypeIn: mTFType) -> Bool {
        
        if self.text == "" {
            self.animationShake()
            return false
        }
        
        var mEvaluate: Bool = false
        switch mTypeIn {
        case .mNumberCard:
            mEvaluate = NSPredicate(format: "SELF MATCHES %@", GKeys.card).evaluate(with: self.text)
        case .mCvc:
            mEvaluate = NSPredicate(format: "SELF MATCHES %@", GKeys.cvc).evaluate(with: self.text)
        case .mNotNull:
            mEvaluate = !(self.text?.isEmpty ?? false)
        case .mPass:
            mEvaluate = NSPredicate(format: "SELF MATCHES %@", GKeys.pass).evaluate(with: self.text)
        case .mEmail:
            mEvaluate = NSPredicate(format: "SELF MATCHES %@", GKeys.email).evaluate(with: self.text)
        case .mCEP:
            mEvaluate = NSPredicate(format: "SELF MATCHES %@", GKeys.cep).evaluate(with: self.text)
        case .mCPF:
            mEvaluate = NSPredicate(format: "SELF MATCHES %@", GKeys.cpf).evaluate(with: self.text)
        case .mPhone:
            mEvaluate = NSPredicate(format: "SELF MATCHES %@", GKeys.phone).evaluate(with: self.text)
        case .mDate:
            mEvaluate = !(self.text?.isEmpty ?? false)
        default:
            break
        }
        
        if !mEvaluate {
            self.animationShake()
        }
        
        return mEvaluate
    }
}
