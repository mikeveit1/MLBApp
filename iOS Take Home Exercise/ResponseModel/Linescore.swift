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
    var inningHalf: String
    var teams: LinescoreTeams
    var scheduledInnings: Int
    var innings: [Inning]
    
    init(currentInning: Int, currentInningOrdinal: String, inningHalf: String, teams: LinescoreTeams, scheduledInnings: Int, innings: [Inning]) {
        self.currentInning = currentInning
        self.currentInningOrdinal = currentInningOrdinal
        self.inningHalf = inningHalf
        self.teams = teams
        self.scheduledInnings = scheduledInnings
        self.innings = innings
    }
}
