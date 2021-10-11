//
//  InningHomeTeam.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/10/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct InningTeam: Codable {
    var runs: Int?
    
    init(runs: Int) {
        self.runs = runs
    }
}
