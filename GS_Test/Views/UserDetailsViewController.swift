//
//  UserDetailsViewController.swift
//  GS_Test
//
//  Created by roshan on 17/06/21.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAgeLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    let userDetailViewModel = UserDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        BindControls()
        navigationItem.title = "User Deatils"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        userDetailViewModel.GetDeatils()
        // Do any additional setup after loading the view.
    }
    
    func BindControls(){
        
        userDetailViewModel.name.bindAndFire {[unowned self] (name) in
            self.userNameLabel.text = name
        }
        
        userDetailViewModel.age.bindAndFire {[unowned self] (age) in
            self.userAgeLabel.text = age
        }
        
        userDetailViewModel.gender.bindAndFire {[unowned self] (gender) in
            self.userGenderLabel.text = gender
        }
        
        userDetailViewModel.image.bindAndFire {[unowned self] (image) in
            self.userImageView.image = image
        }
    }


}
