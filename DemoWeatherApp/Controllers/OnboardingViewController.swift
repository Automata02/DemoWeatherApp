//
//  OnboardingViewController.swift
//  DemoWeatherApp
//
//  Created by roberts.kursitis on 02/11/2022.
//
#warning("TODO: Update second view's button after location services are enabled.")

import UIKit
import CoreLocation

class OnboardingViewController: UIViewController {
    
    @IBOutlet var holderView: UIView!
    
    let scrollView = UIScrollView()
    let locationManager = CLLocationManager()
    
    let TitleLabel = UILabel()
    let ImageView = UIImageView()
    let TextLabel = UILabel()
    let Button = UIButton()
    
    var isStyled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    private func configure() {
        let titles = [
            "Welcome!",
            "Location!",
            "Location!",
            "Done!"
        ]
        
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        for page in 0..<4 {
            let pageView = UIView(frame: CGRect(x: CGFloat(page) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            let obTitleLabel = UILabel()
            let obImageView = UIImageView()
            let obTextLabel = UILabel()
            let obButton = UIButton()
            
            obTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            obImageView.translatesAutoresizingMaskIntoConstraints = false
            obTextLabel.translatesAutoresizingMaskIntoConstraints = false
            obButton.translatesAutoresizingMaskIntoConstraints = false
            
            obTitleLabel.textAlignment = .center
            obTitleLabel.font = .systemFont(ofSize: 31, weight: .semibold)
            pageView.addSubview(obTitleLabel)
            obTitleLabel.text = titles[page]
            
            obImageView.contentMode = .scaleAspectFit
            pageView.addSubview(obImageView)
            
            obTextLabel.font = .systemFont(ofSize: 21, weight: .regular)
            obTextLabel.numberOfLines = 0
            obTextLabel.lineBreakMode = .byClipping
            obTextLabel.textAlignment = .justified
            pageView.addSubview(obTextLabel)

            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .systemGreen
            config.baseForegroundColor = .white
            config.imagePlacement = .leading
            config.imagePadding = 5
            config.buttonSize = .large
            
            switch page {
            case 0:
                obImageView.image = UIImage(named: "NordicWeather")
                obButton.setTitle("Continue", for: .normal)
                obTextLabel.text = "To fully use Nordic Weather app we need to briefly set up a few things."
            case 1:
                obImageView.image = UIImage(systemName: "mappin.and.ellipse")
                obButton.setTitle("Set location permission", for: .normal)
                obTextLabel.text = "We are excited to provide you with weather forecast for your current location. However to present accurate data we need to have Location Services enabled. The app does not store this nor any personal data outside of your iOS device."
                config.image = UIImage(systemName: "location.fill")
                config.baseBackgroundColor = .systemBlue
                config.baseForegroundColor = .white
            case 2:
                obImageView.image = UIImage(systemName: "mappin.and.ellipse")
                obImageView.isHidden = true
                obButton.setTitle("Continue", for: .normal)
                obTextLabel.text = "We're almost there!"
                obTextLabel.textAlignment = .center
                config.image = UIImage(systemName: "location.fill")
                config.baseBackgroundColor = .systemBlue
                config.baseForegroundColor = .white
            case 3:
                obImageView.image = UIImage(systemName: "clock.badge")
                obTextLabel.text = "All done, daily forecast notifications can be enabled within settings as well as Nordic Weather app's theme can be adjusted as from the settings."
                obButton.setTitle("Continue", for: .normal)
            default:
                return
            }
            
            obButton.configuration = config
            obButton.tag = page + 1
            obButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            pageView.addSubview(obButton)
            
            //MARK: Constraints
            NSLayoutConstraint.activate([
                obTitleLabel.heightAnchor.constraint(equalToConstant: 50),
                obTitleLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                obTitleLabel.centerYAnchor.constraint(equalTo: pageView.topAnchor, constant: 60),
                
                obImageView.widthAnchor.constraint(equalToConstant: pageView.frame.width - 60),
                obImageView.heightAnchor.constraint(equalToConstant: pageView.frame.width - 60),
                obImageView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                obImageView.centerYAnchor.constraint(equalTo: obTitleLabel.bottomAnchor, constant: 180),
                
                obTextLabel.widthAnchor.constraint(equalToConstant: pageView.frame.width - 60),
                obTextLabel.topAnchor.constraint(equalTo: obImageView.bottomAnchor, constant: 20),
                obTextLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                
                obButton.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                obButton.bottomAnchor.constraint(equalTo: pageView.bottomAnchor, constant: -30)
            ])
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 4, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
    }
    
    func slidePage(button: UIButton) {
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
    
    @objc func didTapButton(_ button: UIButton) {
        if button.tag == 2 {
            locationManager.requestAlwaysAuthorization()
            locationManagerDidChangeAuthorization(locationManager, button: button)
            //MARK: return here prevent views from switching on first press
//            return
        }
        guard button.tag < 4 else {
            NewUserCheck.shared.notNewUser()
            dismiss(animated: true)
            return
        }
        slidePage(button: button)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, button: UIButton) {
        let status = manager.authorizationStatus

        switch status {
        case .denied, .notDetermined, .restricted:
            DispatchQueue.main.asyncAfter(deadline: .now()){
                self.locationManager.requestAlwaysAuthorization()
            }
        case .authorizedWhenInUse:
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.actionSheet(title: "Heads Up!", message: "Thank you for enabling location services, whilst they will allows the app to function some features might not work correctly as they're enabled by allowing the app to use location services While in Use.")
            }
            slidePage(button: button)
        case .authorizedAlways:
            print("filler")
            slidePage(button: button)
        default:
            return
        }
    }
}

extension OnboardingViewController {
    private func actionSheet(title: String?, message: String?) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self.present(ac, animated: true)
        }
    }
}



