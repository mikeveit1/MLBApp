//
//  GameTeam.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct GameTeam: Codable {
    var score: Int
    var team: Team
    var leagueRecord: LeagueRecord
    
    init(score: Int, team: Team, leagueRecord: LeagueRecord) {
        self.score = score
        self.team = team
        self.leagueRecord = leagueRecord
    }
}
