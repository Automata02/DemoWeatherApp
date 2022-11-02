//
//  OnboardingViewController.swift
//  DemoWeatherApp
//
//  Created by roberts.kursitis on 02/11/2022.
//

import UIKit
import CoreLocation

class OnboardingViewController: UIViewController {
    
    @IBOutlet var holderView: UIView!
    
    let scrollView = UIScrollView()
    let locationManager = CLLocationManager()
    
    var isStyled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    private func configure() {

        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
                
        let titles = [
            "Welcome!",
            "Location!",
            "Almost Ready!"
        ]
        
        for page in 0...2 {
            let pageView = UIView(frame: CGRect(x: CGFloat(page) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            let obTitleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width - 20, height: 120))
            let obImageView = UIImageView(frame: CGRect(x: 60, y: 50, width: pageView.frame.size.width - 120, height: pageView.frame.height - 60 - 130 - 15))
            let obTextLabel = UILabel(frame: CGRect(x: 30, y: 80, width: pageView.frame.size.width - 60, height: 100))
            let obButton = UIButton(frame: CGRect(x: 50, y: pageView.frame.size.height - 100, width: pageView.frame.size.width - 100, height: 50))
            
            obTitleLabel.textAlignment = .center
            obTitleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
            pageView.addSubview(obTitleLabel)
            obTitleLabel.text = titles[page]
            
            obImageView.contentMode = .scaleAspectFit
            pageView.addSubview(obImageView)
            
            obTextLabel.font = .systemFont(ofSize: 22, weight: .medium)
            obTextLabel.numberOfLines = 0
            obTextLabel.lineBreakMode = .byWordWrapping
            obTextLabel.textAlignment = .justified
            pageView.addSubview(obTextLabel)


            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .systemGreen
            config.baseForegroundColor = .white
            config.imagePlacement = .leading
            config.imagePadding = 5
            
            
            switch page {
            case 0:
                obImageView.image = UIImage(named: "NordicWeather")
                obButton.setTitle("Continue", for: .normal)
                obTextLabel.text = "To use Nordic Weather app we need to do some setup"
            case 1:
                obImageView.image = UIImage(systemName: "mappin.and.ellipse")
                obButton.setTitle("Set location permission", for: .normal)
                obTextLabel.text = "We'll provide weather forecast for your location."
                config.image = UIImage(systemName: "location.fill")
                config.baseBackgroundColor = .systemBlue
                config.baseForegroundColor = .white
            case 2:
                obImageView.image = UIImage(systemName: "clock.badge")
                obButton.setTitle("Continue", for: .normal)
            default:
                return
            }
            obButton.configuration = config
            
            obButton.tag = page + 1
            obButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            pageView.addSubview(obButton)
            styleView(views: [obButton, obImageView])
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
    }
    
    @objc func didTapButton(_ button: UIButton) {
        if button.tag == 2 {
            locationManager.requestAlwaysAuthorization()
        }
        guard button.tag < 3 else {
            NewUserCheck.shared.notNewUser()
            dismiss(animated: true)
            return
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
}
