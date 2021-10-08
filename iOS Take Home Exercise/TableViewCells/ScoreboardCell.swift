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
    
    private func setData() {
        
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
        
        configureAwayNameLabel()
        configureAwayRecordLabel()
        configureHomeNameLabel()
        configureHomeRecordLabel()
    }
    
    private func configureAwayNameLabel() {
        
    }
    
    private func configureAwayRecordLabel() {
        
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
