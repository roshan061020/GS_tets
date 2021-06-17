//
//  NetworkService.swift
//  GS_Test
//
//  Created by roshan on 16/06/21.
//

import Foundation

protocol NetworkService {
    func getData(from url: URL, completion:@escaping (Data?, Error?)->Void)
    func getData<T>(from url: String,type: T.Type, completion:@escaping (T?, Error?)->Void) where T:Decodable
}

final class NetworkManager: NetworkService{
    static var shared: NetworkManager = NetworkManager()
    private init(){}
    
    func getData(from url: URL, completion:@escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse{
                debugPrint("For Url \(httpResponse.url!), received reponse with status code \(httpResponse.statusCode)")
            }
            completion(data, error)
        }.resume()
    }
    
    func getData<T>(from url: String,type: T.Type, completion:@escaping (T?, Error?) -> Void) where T : Decodable {
        guard let url = URL(string: url) else{
            debugPrint("Invalid Url passed")
            return
        }
        getData(from: url) { (data, error) in
            guard let data = data, error == nil else{
                completion(nil, error)
                return
            }
            do{
                let parsedjson = try JSONDecoder().decode(T.self, from: data)
                completion(parsedjson, nil)
            }catch {
                completion(nil, error)
            }
            
            
        }
    }
    
   
    
}


