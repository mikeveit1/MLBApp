//
//  Team.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct Teams: Codable {
    var away: GameTeam
    var home: GameTeam
    
    init(away: GameTeam, home: GameTeam) {
        self.away = away
        self.home = home
    }
}
