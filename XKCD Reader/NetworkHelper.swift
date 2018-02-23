//
//  NetworkHelper.swift
//  XKCD Reader
//
//  Created by David Taylor on 2/22/18.
//  Copyright © 2018 Hyper Elephant. All rights reserved.
//

import Foundation

class NetworkHelper {
    class func get(urlSting: String, completionBlock: @escaping (Data) -> Void) {
        // Set up the URL request
        let todoEndpoint: String = urlSting;
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            completionBlock(responseData);
            
        }
        task.resume()
    }}
