//
//  MyCollectionViewCell.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 06/09/2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    static let identifier = "MyCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    public func configure(time: String, emoji: String, temp: Double) {
        timeLabel.text = time
        emojiLabel.text = emoji
        tempLabel.text = String(Int(temp.rounded())) + "°"
    }
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

}
