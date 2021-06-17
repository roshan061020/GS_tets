//
//  UserDetailsViewModel.swift
//  GS_Test
//
//  Created by roshan on 17/06/21.
//

import UIKit

class UserDetailsViewModel{
    var name: Observer<String>
    var age: Observer<String>
    var gender: Observer<String>
    var image: Observer<UIImage>
    
    init() {
        name = Observer<String>("")
        age = Observer<String>("")
        gender = Observer<String>("")
        image = Observer<UIImage>(UIImage(systemName: "person")!.withTintColor(.darkGray))
    }
    
    func GetDeatils(){
        let storageManager = StorageManager.shared
        name.value = storageManager.getFromStorage(for: Constants.name, valueType: String.self) ?? ""
        age.value = storageManager.getFromStorage(for: Constants.age, valueType: String.self) ?? ""
        gender.value = storageManager.getFromStorage(for: Constants.gender, valueType: String.self) ?? ""
        let imgUrl = storageManager.getFromStorage(for: Constants.image, valueType: String.self)
        let imageData = try? Data(contentsOf: URL(string: imgUrl!)!)
        let img = UIImage(data: imageData!)
        image.value = img ?? image.value
    }
}
