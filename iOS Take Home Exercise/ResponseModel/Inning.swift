//
//  Innings.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/10/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct Inning: Codable {
    var num: Int?
    var home: InningTeam?
    var away: InningTeam?
    
    init(num: Int, home: InningTeam, away: InningTeam) {
        self.num = num
        self.home = home
        self.away = away
    }
}
