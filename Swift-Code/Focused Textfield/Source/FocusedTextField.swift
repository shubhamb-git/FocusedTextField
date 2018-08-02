//
//  FocusedTextField.swift
//  Focused Textfield
//
//  Created by Shubh on 02/08/18.
//  Copyright © 2018 Shubh. All rights reserved.
//

import UIKit


enum screenWidth {
    case ScreenSizeUnknown
    case ScreenSize3_5inch
    case ScreenSize4inch
    case ScreenSize4_7inch
    case ScreenSize5_5inch
}

let SCREEN_SIZE = UIScreen.main.bounds.size
let SCREEN_BOUNDS = UIScreen.main.bounds
let WIDTH_3_5_INCH: CGFloat = 320.0
let WIDTH_4_INCH: CGFloat   = 320.0
let WIDTH_4_7_INCH: CGFloat = 375.0
let WIDTH_5_5_INCH: CGFloat = 414.0



class FocusedTextField : UITextField {
    
    @IBInspectable var leftIcon: UIImage?
    @IBInspectable var iconInset: CGFloat = 10
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let aLayer              = CAGradientLayer()
        aLayer.frame            = self.bounds
        aLayer.startPoint       = CGPoint.zero
        aLayer.colors           = [#colorLiteral(red: 0.2666666667, green: 0.2784313725, blue: 0.3137254902, alpha: 1).cgColor, #colorLiteral(red: 0.3529411765, green: 0.368627451, blue: 0.4156862745, alpha: 1).cgColor]
        aLayer.startPoint       = CGPoint(x: 0.0, y: 0.5)
        aLayer.endPoint         = CGPoint(x: 1.0, y: 0.5)
        aLayer.shadowColor      = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        aLayer.shadowOpacity    = 0.5
        aLayer.shadowOffset     = CGSize.zero
        aLayer.shadowRadius     = 5.0
        aLayer.shouldRasterize  = true
        aLayer.cornerRadius     = self.bounds.height/2
        aLayer.masksToBounds    = false
        return aLayer
    }()
    
    private var customLeftView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.borderStyle = .none
        self.addTarget(self, action: #selector(self.begingEdit), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.endEdit), for: .editingDidEnd)
    }
    
    override func awakeFromNib() {
        if let leftIcon = leftIcon {
            let width = 20 + (iconInset*2)
            customLeftView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.bounds.height))
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: leftIcon.size.width, height: leftIcon.size.height))
            imgView.image = leftIcon
            imgView.center = CGPoint(x: customLeftView!.bounds.width/2, y: customLeftView!.bounds.height/2)
            customLeftView?.addSubview(imgView)
            self.leftView = customLeftView
            self.leftViewMode = .always
        }
        let fntSize = SCREEN_SIZE.width * self.getFontRatio(size: screenWidth.ScreenSize4inch.hashValue)
        self.font = UIFont(name: self.font!.fontName, size: fntSize)
    }
    
    private func getFontRatio(size : Int) -> CGFloat {
        let srcWdthArray = [SCREEN_SIZE.width, WIDTH_3_5_INCH, WIDTH_4_INCH, WIDTH_4_7_INCH, WIDTH_5_5_INCH]
        let wdth = srcWdthArray[size]
        return self.font!.pointSize / wdth
    }
    
    @objc func begingEdit() {
        self.gradientLayer.frame = self.bounds
        UIView.transition(with: self,
                          duration:0.2,
                          options: .transitionCrossDissolve,
                          animations: { self.layer.insertSublayer(self.gradientLayer, at: 0) },
                          completion: nil)
    }
    
    @objc func endEdit() {
        self.gradientLayer.frame = self.bounds
        UIView.transition(with: self,
                          duration:0.2,
                          options: .transitionCrossDissolve,
                          animations: { self.gradientLayer.removeFromSuperlayer() },
                          completion: nil)
    }
}
