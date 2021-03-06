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
    case preview = "Preview"
    case inProgress = "Live"
    case final = "Final"
}

internal func getGameStatus(score: ScoreDisplay) -> String {
    var status = String()
    if let state = GameStatus.init(rawValue: score.gameState) {
        switch state {
        case .final:
            status = score.gameState
            if score.inning != score.scheduledInnings {
                status = "F/\(score.inning)"
            }
            break
        case .inProgress:
            status = "\(score.inningHalf) \(score.inningOrdinal)"
            break
        case .preview:
            status = getDateString(date: score.gameDate, format: timeFormat)
            break
        }
    }
    return status
}
