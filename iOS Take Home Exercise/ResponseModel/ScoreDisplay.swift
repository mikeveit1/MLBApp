//
//  ScoreDisplay.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct ScoreDisplay {
    var officialDate: Date
    var gameDate: Date
    var awayTeamName: String
    var awayTeamAbbreviation: String
    var awayTeamRecord: String
    var homeTeamName: String
    var homeTeamAbbreviation: String
    var homeTeamRecord: String
    var awayTeamRuns: Int
    var awayTeamHits: Int
    var awayTeamErrors: Int
    var homeTeamRuns: Int
    var homeTeamHits: Int
    var homeTeamErrors: Int
    var inning: Int
    var inningOrdinal: String
    var inningHalf: String
    var gameState: String
    var scheduledInnings: Int
    var venueName: String
    var venueCity: String
    var venueState: String
    var innings: [Inning]
}
