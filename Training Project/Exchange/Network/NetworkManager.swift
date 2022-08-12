//
//  NetworkManager.swift
//  Training Project
//
//  Created by VironIT on 8/11/22.
//

import Foundation

class NetworkManager {
    
     func getUSD() {
        guard var urlComponents = URLComponents(string: APIConst.baseURL + "usd") else { return }
        urlComponents.queryItems = [URLQueryItem(name: APIConst.mode, value: "2")]
        guard let url = urlComponents.url else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                print("Error")
                return
            }
            
//            var result: Exchange?
//            
//            do {
//                try result = JSONDecoder().decode(Exchange.self, from: data)
//            } catch {
//                print("error")
//            }
            
            print(String(data: data, encoding: .utf8) ?? "no data")
            
        })
        task.resume()
    }
    
    func getCurrency(for currency:String) {
       guard var urlComponents = URLComponents(string: APIConst.baseURL + currency) else { return }
       urlComponents.queryItems = [URLQueryItem(name: APIConst.mode, value: "2")]
       guard let url = urlComponents.url else { return }
       let session = URLSession(configuration: .default)
       let task = session.dataTask(with: url, completionHandler: {data, _, error in
           guard let data = data, error == nil else {
               print("Error")
               return
           }
           
//           var result: Exchange?
//           
//           do {
//               try result = JSONDecoder().decode(Exchange.self, from: data)
//           } catch {
//               print("error")
//           }
           
           print(String(data: data, encoding: .utf8) ?? "no data")
           
       })
       task.resume()
   }
}
