//
//  Linescore.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct Linescore: Codable {
    var currentInning: Int
    var currentInningOrdinal: String
    var inningState: String
    var teams: LinescoreTeams
    var scheduledInnings: Int
    
    init(currentInning: Int, currentInningOrdinal: String, inningState: String, teams: LinescoreTeams, scheduledInnings: Int) {
        self.currentInning = currentInning
        self.currentInningOrdinal = currentInningOrdinal
        self.inningState = inningState
        self.teams = teams
        self.scheduledInnings = scheduledInnings
    }
}
