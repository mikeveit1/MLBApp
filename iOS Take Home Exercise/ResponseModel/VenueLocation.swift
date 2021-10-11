//
//  VenueLocation.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/10/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct VenueLocation: Codable {
    var city: String
    var state: String
    
    init(city: String, state: String) {
        self.city = city
        self.state = state
    }
}
