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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setData(score: ScoreDisplay) {
        configureLabel(label: awayNameLabel, data: score.awayTeamName)
        configureLabel(label: awayRecordLabel, data: score.awayTeamRecord)
        configureLabel(label: homeNameLabel, data: score.homeTeamName)
        configureLabel(label: homeRecordLabel, data: score.homeTeamRecord)
        configureLabel(label: awayScoreLabel, data: "\(score.awayTeamScore)")
        configureLabel(label: homeScoreLabel, data: "\(score.homeTeamScore)")
        var status = String()
        if score.gameState == "Final" {
            status = score.gameState
            if score.inning != score.scheduledInnings {
                status = "F/\(score.inning)"
            }
        } else {
            status = "\(score.inning)"
        }
        configureLabel(label: inningLabel, data: status)
    }
    
    private func setUpViews() {
        configureView()
        configureGameStackView()
    }
    
    private func configureView() {
        self.backgroundColor = Colors.backgroundColor
    }
    
    private func configureGameStackView() {
        configureTeamStackView()
        configureScoreStackView()
        configureInningStackView()
    }
    
    private func configureTeamStackView() {
        
        configureHomeNameLabel()
        configureHomeRecordLabel()
    }
    
    private func configureLabel(label: UILabel, data: String) {
        label.textColor = Colors.textColor
        label.text = data
    }
    
    private func configureAwayRecordLabel(record: String) {
        awayRecordLabel.textColor = Colors.textColor
        awayRecordLabel.text = record
    }
    
    private func configureHomeNameLabel() {
        
    }
    
    private func configureHomeRecordLabel() {
        
    }
    
    private func configureScoreStackView() {
        let labels = [awayScoreLabel, homeScoreLabel]
        for label in labels {
            configureScoreLabel(label: label!)
        }
    }
    
    private func configureScoreLabel(label: UILabel) {
        
    }
    
    private func configureInningStackView() {
        configureInningLabel()
    }
    
    private func configureInningLabel() {
    
    }
}
