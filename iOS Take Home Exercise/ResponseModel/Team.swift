//
//  Team.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct Team: Codable {
    var teamName: String
    
    init(teamName: String) {
        self.teamName = teamName
    }
}
