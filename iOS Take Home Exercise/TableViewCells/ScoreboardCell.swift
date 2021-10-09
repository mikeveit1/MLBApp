//
//  ScoreboardTableCellTableViewCell.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import UIKit

class ScoreboardCell: UITableViewCell {
    
    @IBOutlet weak var gameStackView: UIStackView!
    @IBOutlet weak var teamStackView: UIStackView!
    @IBOutlet weak var awayStackView: UIStackView!
    @IBOutlet weak var awayNameLabel: UILabel!
    @IBOutlet weak var awayRecordLabel: UILabel!
    @IBOutlet weak var homeStackView: UIStackView!
    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var homeRecordLabel: UILabel!
    @IBOutlet weak var scoreStackView: UIStackView!
    @IBOutlet weak var awayScoreLabel: UILabel!
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var inningStackView: UIStackView!
    @IBOutlet weak var inningLabel: UILabel!
    @IBOutlet weak var noScheduledGamesLabel: UILabel!
    private var allLabels: [UILabel] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Colors.backgroundColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func handleNoScheduledGames(hideLabels: Bool) {
        noScheduledGamesLabel.isHidden = !hideLabels
        configureLabel(label: noScheduledGamesLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "No Scheduled Games")
        for label in allLabels.filter({$0 != noScheduledGamesLabel }) {
            label.isHidden = hideLabels
        }
    }
    
    public func setData(score: ScoreDisplay) {
        handleNoScheduledGames(hideLabels: false)
        configureLabel(label: awayNameLabel, color: Colors.textColor, font: Fonts.mediumFont, data: score.awayTeamName)
        configureLabel(label: awayRecordLabel, color: Colors.separatorColor, font: Fonts.smallFont, data: score.awayTeamRecord)
        configureLabel(label: homeNameLabel, color: Colors.textColor, font: Fonts.mediumFont, data: score.homeTeamName)
        configureLabel(label: homeRecordLabel, color: Colors.separatorColor, font: Fonts.smallFont, data: score.homeTeamRecord)
        configureLabel(label: awayScoreLabel, color: Colors.textColor, font: Fonts.largeFont, data: "\(score.awayTeamScore)")
        configureLabel(label: homeScoreLabel, color: Colors.textColor, font: Fonts.largeFont, data: "\(score.homeTeamScore)")
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
            case .notStarted:
                dateFormatter.dateFormat = "h:mm a"
                status = dateFormatter.string(from: score.gameDate)
                break
            }
        }
       /* if score.inning == score.scheduledInnings {
            if score.gameState == "Final" {
                status = score.gameState
                if score.inning != score.scheduledInnings {
                    status = "F/\(score.inning)"
                }
            } else {
                status = "\(score.inning)"
            }*/
            configureLabel(label: inningLabel, color: Colors.mlbBlue, font: Fonts.mediumFont, data: status)
        }
    
    private func configureLabel(label: UILabel, color: UIColor, font: UIFont, data: String) {
        allLabels.append(label)
        label.textColor = color
        label.font = font
        label.text = data
    }
    
    enum GameStatus: String {
        case notStarted = "Not_Started"
        case inProgress = "In_Progress"
        case completed = "Final"
    }
}
