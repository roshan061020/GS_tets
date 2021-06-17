//
//  UserTableViewCellViewModel.swift
//  GS_Test
//
//  Created by roshan on 17/06/21.
//

import Foundation

class UserTableViewCellViewModel{
    var celldata: Observer<FavoriteUser>
    var homeviewmodel:HomeViewModel
    init(userData: FavoriteUser, homeviewmodel: HomeViewModel){
        celldata = Observer<FavoriteUser>(userData)
        self.homeviewmodel = homeviewmodel
    }
    
    func userLikedStatusToggled(){
        celldata.value.isLiked = !celldata.value.isLiked
        homeviewmodel.setLikedState(to: celldata.value.isLiked, userId: celldata.value.id)
    }
    
    
}
