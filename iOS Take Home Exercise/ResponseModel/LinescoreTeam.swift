//
//  LinescoreTeams.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct LinescoreTeam: Codable {
    var runs: Int?
    var hits: Int?
    var errors: Int?
    
    init(runs: Int, hits: Int, errors: Int) {
        self.runs = runs
        self.hits = hits
        self.errors = errors
    }
}
