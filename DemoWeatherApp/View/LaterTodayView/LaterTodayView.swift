//
//  laterTodayView.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 05/09/2022.
//

import UIKit
@IBDesignable

class LaterTodayView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nextHourLabel: UILabel!
    @IBOutlet weak var nextSixHoursLabel: UILabel!
    @IBOutlet weak var nextTwelveHoursLabel: UILabel!
    
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
        let nib = UINib(nibName: "LaterTodayView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

