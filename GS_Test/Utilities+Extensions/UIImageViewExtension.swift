//
//  UIImagePickerExtension.swift
//  GS_Test
//
//  Created by roshan on 15/06/21.
//

import UIKit

extension UIImageView{
    
    func addTapGesture(target: Any?, action:Selector){
        self.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: target, action: action)
        tapgesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapgesture)
    }
    
    func setImageFrom(url: URL){
        NetworkManager.shared.getData(from: url) { (data, error) in
            if error == nil && data != nil{
                let image =  UIImage(data: data!)
                self.image = image
                
            }
        }
    }
}
