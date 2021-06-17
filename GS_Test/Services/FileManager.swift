//
//  FileManager.swift
//  GS_Test
//
//  Created by roshan on 17/06/21.
//

import Foundation

final class GSFileManager{
    static let shared = GSFileManager()
    private init(){}
    
    ///Mark :-
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
