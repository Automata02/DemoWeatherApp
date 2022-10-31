//
//  mapDetailView.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 01/09/2022.
//

import UIKit
@IBDesignable

class WeatherNowView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var pptLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var sixHourCaptionLabel: UILabel!
    @IBOutlet weak var twelveHourCaptionLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
        
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WeatherNowView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

