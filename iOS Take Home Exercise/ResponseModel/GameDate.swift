//
//  Date.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct GameDate: Codable {
    var date: String
    var totalGames: Int
    var games: [Game]
    
    init(date: String, totalGames: Int, games: [Game]) {
        self.date = date
        self.totalGames = totalGames
        self.games = games
    } 
}
