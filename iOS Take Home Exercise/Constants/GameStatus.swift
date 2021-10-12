//
//  GameStatus.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/10/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation
import UIKit

enum GameStatus: String {
    case scheduled = "Scheduled"
    case inProgress = "In Progress"
    case completed = "Final"
}

internal func getGameStatus(score: ScoreDisplay) -> String {
    var status = String()
    if let state = GameStatus.init(rawValue: score.gameState) {
        switch state {
        case .completed:
            status = score.gameState
            if score.inning != score.scheduledInnings {
                status = "F/\(score.inning)"
            }
            break
        case .inProgress:
            status = "\(score.inningHalf) \(score.inningOrdinal)"
            break
        case .scheduled:
            dateFormatter.dateFormat = timeFormat
            status = dateFormatter.string(from: score.gameDate)
            break
        }
    }
    return status
}
