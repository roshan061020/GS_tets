//
//  UserTableViewCell.swift
//  GS_Test
//
//  Created by roshan on 16/06/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageVIew: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userLikedButton: UIButton!
    var userTableViewCellViewModel: UserTableViewCellViewModel?{
        didSet{
            Bind()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func Bind(){
        userTableViewCellViewModel?.celldata.bindAndFire({[weak self] (userData) in
            self?.setData(userData: userData)
        })
    }
    
    @IBAction func toggleLikedState(_ sender: UIButton) {
        userTableViewCellViewModel?.userLikedStatusToggled()
    }
    
    fileprivate func likedButtonStateChnaged(_ state: Bool) {
        if state{
            userLikedButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        }else{
            userLikedButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            
        }
    }
    
    private func setData(userData: FavoriteUser){
        userImageVIew.sd_setImage(with: userData.pictureUrl, placeholderImage: UIImage(systemName: "person.fill"), options: [], context: nil)
        userNameLabel.text = userData.name
        userGenderLabel.text = userData.gender
        userEmailLabel.text = userData.email
        likedButtonStateChnaged(userData.isLiked)
    }
}
