//
//  Team.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation

struct Team: Codable {
    var teamName: String?
    var abbreviation: String?
    
    init(teamName: String, abbreviation: String) {
        self.teamName = teamName
        self.abbreviation = abbreviation
    }
}
