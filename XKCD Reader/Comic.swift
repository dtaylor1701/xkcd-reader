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
    
}


