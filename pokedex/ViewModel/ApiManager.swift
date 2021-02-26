//
//  ApiManager.swift
//  pokedex
//
//  Created by APPMAN M-021 on 8/2/2564 BE.
//

import Foundation
import UIKit

class AppleApiManager: NSObject {
    func getData(url: URL, completion: @escaping (Any?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let response = response {
                print(response)
            }

            //cast to JSON format
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                completion(json)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
    func postData(url: URL, medthod: String, params: [String: Any], completion: @escaping (Any?) -> Void) {
        let jsonParams = try? JSONSerialization.data(withJSONObject: params, options: [])

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = medthod.uppercased() //"POST"

        request.httpBody = jsonParams

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
            completion(jsonResponse)
        }
        task.resume()
    }
}
