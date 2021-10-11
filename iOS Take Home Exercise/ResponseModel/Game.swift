//
//  Game.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct Game: Codable {
    var gameDate: String
    var status: Status
    var teams: Teams
    var linescore: Linescore
    var venue: Venue
    
    init(gameDate: String, status: Status, teams: Teams, linescore: Linescore, venue: Venue) {
        self.gameDate = gameDate
        self.status = status
        self.teams = teams
        self.linescore = linescore
        self.venue = venue
    }
}
