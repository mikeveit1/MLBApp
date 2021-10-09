//
//  LinescoreTeams.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct LinescoreTeams: Codable {
    var home: LinescoreTeam
    var away: LinescoreTeam
    
    init(home: LinescoreTeam, away: LinescoreTeam) {
        self.home = home
        self.away = away
    }
}
