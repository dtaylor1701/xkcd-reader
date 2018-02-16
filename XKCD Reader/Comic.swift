//
//  Comic.swift
//  XKCD Reader
//
//  Created by David Taylor on 2/15/18.
//  Copyright © 2018 Hyper Elephant. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let month: Int
    let num: Int
    let title: String
}
