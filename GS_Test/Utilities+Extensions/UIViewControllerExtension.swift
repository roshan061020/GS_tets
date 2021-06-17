//
//  UIViewControllerExtension.swift
//  GS_Test
//
//  Created by ro361001 on 17/06/21.
//

import UIKit

extension UIViewController{
    func showAlert(withTitle title: String, message msg:String){
      let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .default){_ in }
      alert.addAction(okButton)
      self.present(alert, animated: true, completion: nil)
    }
}
