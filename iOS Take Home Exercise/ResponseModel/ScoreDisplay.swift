//
//  ScoreDisplay.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct ScoreDisplay  {
    var officialDate: Date
    var gameDate: Date
    var awayTeamName: String
    var awayTeamRecord: String
    var homeTeamName: String
    var homeTeamRecord: String
    var awayTeamScore: Int
    var homeTeamScore: Int
    var inning: Int
    var inningOrdinal: String
    var inningHalf: String
    var gameState: String
    var scheduledInnings: Int
}
