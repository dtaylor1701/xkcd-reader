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
            let decoder = JSONDecoder()
            var comicData = try decoder.decode(Comic.self, from: data)
            if let str = String(data: comicData.alt.data(using: .isoLatin1)!, encoding: .utf8) {
                comicData = Comic(num: comicData.num, title: comicData.title, img: comicData.img, alt: str)
            }
            return comicData
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


