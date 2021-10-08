//
//  ScoreboardTableCellTableViewCell.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import UIKit

class ScoreboardCell: UITableViewCell {

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
    }
    
    private func configureView() {
        self.backgroundColor = Colors.backgroundColor
    }

}
