//
//  HomeViewModel.swift
//  GS_Test
//
//  Created by roshan on 16/06/21.
//

import Foundation

class FavoriteUser{
    var name: String
    var gender: String
    var pictureString: String
    var age: Int
    var email: String
    var phoneNumber: String
    var isLiked: Bool
    var id: String
    
    var pictureUrl: URL?{
        URL(string: pictureString)
    }
    
    init(name: String, gender: String, pictureString: String, age: Int, email: String, phoneNumber: String, id: String, isLiked: Bool = false ) {
        self.name = name
        self.gender = gender
        self.pictureString = pictureString
        self.age = age
        self.email = email
        self.phoneNumber = phoneNumber
        self.isLiked = isLiked
        self.id = id
    }
}


class HomeViewModel{
    let allGender = "All"
    var users: [FavoriteUser]?{
        didSet{
            Filter(selectedGender)
        }
    }
    
    var genderSegment: [String]
    var filteredUsers = Observer<[FavoriteUser]>([])
    var selectedGender : String
    var errorMessage: Observer<String>
    init(){
        genderSegment = Gender.getAllCases
        genderSegment.append(allGender)
        genderSegment.reverse()
        selectedGender = allGender
        errorMessage = Observer<String>("")
    }
    
     func getUsersData(){
        
        NetworkManager.shared.getData(from: Constants.APIS.dataApi, type: Users.self) {[weak self] (users, error) in
            guard error == nil else{
                self?.errorMessage.value = error?.localizedDescription ?? ""
                return
            }
            guard let users = users else{return}
            self?.users = users.map{FavoriteUser(name: $0.name, gender: $0.gender.toString(), pictureString: $0.picture, age: $0.age, email: $0.email, phoneNumber: $0.phone,id: $0.id)}
        }
    }
    
    func Filter(_ gender: String){
        selectedGender = gender
        if gender == allGender{
            filteredUsers.value = users ?? []
        }
        else{
            filteredUsers.value = users!.filter({ (user) -> Bool in
                user.gender == gender
            })
        }
    }
    
    func setLikedState(to newState: Bool, userId id: String){
        let user = users?.first{$0.id == id}
        user?.isLiked = newState
        Filter(selectedGender)
    }
    
}

