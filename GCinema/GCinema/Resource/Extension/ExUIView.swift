//
//  ExUIView.swift
//  GCinema
//
//  Created by Edu on 03/03/21.
//

import Foundation
import UIKit

extension UIView {
    
    enum DirectionX {
        case Left
        case Right
    }
    
    enum DirectionY {
        case Top
        case Bottom
    }
    
    func animationSlideInHorizontal(delay: Double, direction: DirectionX, block: @escaping ()->()){
        self.isHidden = true
        if(DirectionX.Left == direction){
            self.transform = CGAffineTransform(translationX: -400, y: 0)
        }else{
            self.transform = CGAffineTransform(translationX: 400, y: 0)
        }
        UIView.animate(withDuration: delay,  animations: {
            self.isHidden = false
            self.transform = CGAffineTransform(translationX: 0, y: 0)
            self.alpha = 1
        },  completion: { finished in
            block()
        })
    }
    
    func animationSlideInVertical(delay: Double, direction: DirectionY, block: @escaping ()->()){
        self.isHidden = true
        if(DirectionY.Top == direction){
            self.transform = CGAffineTransform(translationX: 0, y: -400)
        }else{
            self.transform = CGAffineTransform(translationX: 0, y: 800)
        }
        UIView.animate(withDuration: delay,  animations: {
            self.isHidden = false
            self.transform = CGAffineTransform(translationX: 0, y: 0)
            self.alpha = 1
        },  completion: { finished in
            block()
        })
    }
    
    func animationSlideOutVertical(delay: Double, directionIn: DirectionY, block: @escaping ()->()){
        
        UIView.animate(withDuration: delay, delay: 0.0, options: .curveEaseOut, animations: {
            if(DirectionY.Top == directionIn){
                self.transform = CGAffineTransform(translationX: 0, y: -400)
            }else{
                self.transform = CGAffineTransform(translationX: 0, y: 800)
            }
        }, completion: { finished in
            block()
        })
    }
    
    func animationFaceIn(durationIn: TimeInterval = 1.0, delayIn: TimeInterval = 0.0, alphaIn: CGFloat, completionIn: @escaping ((Bool) -> ()) = {(onFinish: Bool) -> () in}) {
        self.alpha = 0
        UIView.animate(withDuration: durationIn, delay: delayIn, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = alphaIn
            self.isHidden = false
        }, completion: completionIn)
        
    }
    
    func animationFaceOut(durationIn: TimeInterval = 1.0, delayIn: TimeInterval = 0.0, alphaIn: CGFloat, completionIn: @escaping ((Bool) -> ()) = {(onFinish: Bool) -> () in}) {
        self.alpha = 1
        UIView.animate(withDuration: durationIn, delay: delayIn, options:     UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = alphaIn
            self.isHidden = true
        }, completion: completionIn)
        
    }

    func animationShake() {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    func animationAlpha(delay: Double, block: @escaping ()->()){
        self.isHidden = false
        self.alpha = 0.0
        UIView.animate(withDuration: delay,  animations: {
            self.alpha = 1.0
        },  completion: { finished in
            self.alpha = 1.0
            block()
        })
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }

    func removeProcessor() {
        self.subviews.forEach { (it) in
            if it.tag == 109 {
                it.removeFromSuperview()
            }
        }
    }
    
    func addVBorder(cornersIn: UIRectCorner, radiusIn: CGFloat, roundedRectIn: CGRect? = nil) {
        let mPath = UIBezierPath(roundedRect: roundedRectIn ?? bounds, byRoundingCorners: cornersIn, cornerRadii: CGSize(width: radiusIn, height: radiusIn))
        let mMask = CAShapeLayer()
        mMask.path = mPath.cgPath
        layer.mask = mMask
        self.setNeedsLayout()
    }
    
    func addVerticalGradient(colorTopIn: UIColor = .clear, colorBottomIn: UIColor = .clear) {
        
        let mGLayer = CAGradientLayer()
        mGLayer.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 80)
        mGLayer.colors = [colorTopIn.cgColor, colorBottomIn.cgColor]
        mGLayer.locations = [0.6, 1.0]
        mGLayer.zPosition = -1
        self.layer.addSublayer(mGLayer)
    }
}
