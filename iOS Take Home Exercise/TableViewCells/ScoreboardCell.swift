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
        configureLabel(label: noScheduledGamesLabel, color: Colors.textColor, data: "No Scheduled Games")
        for label in allLabels.filter({$0 != noScheduledGamesLabel }) {
            label.isHidden = hideLabels
        }
    }
    
    public func setData(score: ScoreDisplay) {
        handleNoScheduledGames(hideLabels: false)
        configureLabel(label: awayNameLabel, color: Colors.textColor, data: score.awayTeamName)
        configureLabel(label: awayRecordLabel, color: Colors.textColor, data: score.awayTeamRecord)
        configureLabel(label: homeNameLabel, color: Colors.textColor, data: score.homeTeamName)
        configureLabel(label: homeRecordLabel, color: Colors.textColor, data: score.homeTeamRecord)
        configureLabel(label: awayScoreLabel, color: Colors.textColor, data: "\(score.awayTeamScore)")
        configureLabel(label: homeScoreLabel, color: Colors.textColor, data: "\(score.homeTeamScore)")
        var status = String()
        if score.gameState == "Final" {
            status = score.gameState
            if score.inning != score.scheduledInnings {
                status = "F/\(score.inning)"
            }
        } else {
            status = "\(score.inning)"
        }
        configureLabel(label: inningLabel, color: Colors.mlbBlue, data: status)
    }
    
    private func configureLabel(label: UILabel, color: UIColor, data: String) {
        allLabels.append(label)
        label.textColor = color
        label.text = data
    }
}
