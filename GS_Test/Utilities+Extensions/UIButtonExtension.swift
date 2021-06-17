//
//  UIButtonExtension.swift
//  GS_Test
//
//  Created by roshan on 15/06/21.
//

import UIKit

extension UIButton{
    var cornerRadius: Float{
        get{ Float(self.layer.cornerRadius)}
        set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    var borderColor: UIColor{
        get{
            let currentColor = self.layer.borderColor
            if let currentColor = currentColor{
                return UIColor(cgColor: currentColor)
            }else{
                return UIColor.clear
            }
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    var borderWidth: Float{
        get{ Float(self.layer.borderWidth)}
        set{
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
}
