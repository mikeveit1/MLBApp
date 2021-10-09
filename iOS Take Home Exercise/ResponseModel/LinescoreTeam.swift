//
//  LinescoreTeams.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct LinescoreTeam: Codable {
    var runs: Int
    
    init(runs: Int) {
        self.runs = runs
    }
}
