//
//  Comic.swift
//  XKCD Reader
//
//  Created by David Taylor on 2/15/18.
//  Copyright © 2018 Hyper Elephant. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let num: Int
    let title: String
    let img: String
    let alt: String
    
    init(num: Int, title: String, img: String, alt: String) {
        self.num = num;
        self.title = title;
        self.img = img;
        self.alt = alt;
    }
    
    static let DefaultURL = "https://xkcd.com/info.0.json"
    
    static func ComicFromJSON(data: Data) -> Comic? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return nil
            }
            
            print("Comic: " + json.description)
            
            guard let title = json["title"] as? String else {
                print("Could not get comic title from JSON")
                return nil
            }
            guard let num = json["num"] as? Int else {
                print("Could not get comic number from JSON")
                return nil
            }
            guard let alt = String(utf8String: json["alt"] as! UnsafePointer<CChar>) else {
                print("Could not get comic alt from JSON")
                return nil
            }
            print(alt)
            guard let img = json["img"] as? String else {
                print("Could not get comic img from JSON")
                return nil
            }
            
            return Comic(num: num, title: title, img: img, alt: alt)
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
    static func URLString(num: Int) -> String {
        return "https://xkcd.com/\(num)/info.0.json"
    }
    
    static func ComicURL(num: Int) -> URL? {
        
        let urlString = "https://xkcd.com/\(num)"
        if let url = URL(string: urlString){
            return url
        }
        return nil
    }
}


