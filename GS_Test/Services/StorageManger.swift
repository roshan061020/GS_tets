//
//  StorageManger.swift
//  GS_Test
//
//  Created by roshan on 17/06/21.
//

import Foundation

final class StorageManager{
    static let shared = StorageManager()
    private init(){}
    
    let storage = UserDefaults.standard
    
    
    func saveToStorage<T>(for key:String,value:T){
        storage.setValue(value, forKey: key)
    }
    
    func getFromStorage<T>(for key: String, valueType: T.Type)->T?{
        storage.object(forKey: key) as? T
    }
}
