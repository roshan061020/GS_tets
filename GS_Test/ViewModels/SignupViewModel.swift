//
//  SignupViewModel.swift
//  GS_Test
//
//  Created by roshan on 15/06/21.
//

import Foundation
import UIKit

class SignUpViewModel{
    let now = Date()
    var Genders: [String] = Gender.getAllCases
    var dobMaxLimit: Date {
        return Calendar.current.date(byAdding: .year, value: -14, to: now) ?? now
    }
    
    var dobMinLimit: Date {
        return Calendar.current.date(byAdding: .year, value: -150, to: now) ?? now
    }
    
    var isSignInSuccessfull: Observer<Bool>
    
    init() {
        isSignInSuccessfull = Observer(false)
    }
    
    
    func triggerSignUp(forUser name: String,dob: String, gender: String, image: UIImage){
        // api call can be made here
        // using sleep to mock the same
        
        
        if let data = image.pngData() {
            let filename = GSFileManager.shared.getDocumentsDirectory().appendingPathComponent("\(name).png")
            do{
                try data.write(to: filename)
                StorageManager.shared.saveToStorage(for: Constants.image, value: filename.absoluteString)
            }catch {
                debugPrint("Error while saving image")
            }
        }
        
        let age = calculateAge(dob)
        StorageManager.shared.saveToStorage(for: Constants.name, value: name)
        StorageManager.shared.saveToStorage(for: Constants.age, value: "\(age)")
        StorageManager.shared.saveToStorage(for: Constants.gender, value: gender)
        
        DispatchQueue.global().async {[weak self] in
            self?.isSignInSuccessfull.value = true
        }
    }
    
    func calculateAge(_ dob: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM dd yyyy"
        let birthDate = dateFormater.date(from: dob)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
        
}
