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
    @IBOutlet weak var statusStackView: UIStackView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var noScheduledGamesLabel: UILabel!
    private var allLabels: [UILabel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Colors.backgroundColor
    }
    
    public func handleNoScheduledGames(hideLabels: Bool) {
        noScheduledGamesLabel.isHidden = !hideLabels
        configureLabel(label: noScheduledGamesLabel, color: labelTextColor, font: Fonts.mediumFont, data: "No Scheduled Games")
        for label in allLabels.filter({$0 != noScheduledGamesLabel }) {
            label.isHidden = hideLabels
        }
    }
    
    public func setData(score: ScoreDisplay) {
        handleNoScheduledGames(hideLabels: false)
        configureLabel(label: awayNameLabel, color: labelTextColor, font: Fonts.mediumFont, data: score.awayTeamName)
        configureLabel(label: awayRecordLabel, color: Colors.separatorColor, font: Fonts.smallFont, data: score.awayTeamRecord)
        configureLabel(label: homeNameLabel, color: labelTextColor, font: Fonts.mediumFont, data: score.homeTeamName)
        configureLabel(label: homeRecordLabel, color: Colors.separatorColor, font: Fonts.smallFont, data: score.homeTeamRecord)
        configureLabel(label: awayScoreLabel, color: labelTextColor, font: Fonts.largeFont, data: "\(score.awayTeamRuns)")
        configureLabel(label: homeScoreLabel, color: labelTextColor, font: Fonts.largeFont, data: "\(score.homeTeamRuns)")
        configureLabel(label: statusLabel, color: Colors.mlbBlue, font: Fonts.mediumFont, data: getGameStatus(score: score))
    }
    
    private func configureLabel(label: UILabel, color: UIColor, font: UIFont, data: String) {
        allLabels.append(label)
        label.textColor = color
        label.font = font
        label.text = data
    }
}
