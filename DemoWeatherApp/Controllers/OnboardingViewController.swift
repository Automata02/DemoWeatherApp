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
    
    let TitleLabel = UILabel()
    let ImageView = UIImageView()
    let TextLabel = UILabel()
    let Button = UIButton()
    
    var isStyled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
        
        //MARK: Gradient Layer settings
        let gradientLayer = CAGradientLayer()
        let pinkTone = #colorLiteral(red: 0.9607843137, green: 0.8352941176, blue: 0.8705882353, alpha: 1)
        let blueTone = #colorLiteral(red: 0.137254902, green: 0.6666666667, blue: 0.8823529412, alpha: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.type = .radial
        gradientLayer.colors = [blueTone.cgColor, pinkTone.cgColor]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.zPosition = -10
        holderView.backgroundColor = .clear
        
        for page in 0..<4 {
            let pageView = UIView(frame: CGRect(x: 0, y: CGFloat(page) * holderView.frame.size.height, width: holderView.frame.size.width, height: holderView.frame.size.height))
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
            obTextLabel.lineBreakMode = .byWordWrapping
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
                obTextLabel.text = "We are excited to provide you with weather forecast for your current location but before that we need to briefly set up a few things."
            case 1:
                obImageView.image = UIImage(named: "mapViewMockup")
                obButton.setTitle("Set location permission", for: .normal)
                obTextLabel.text = "To present accurate data we need to have Location Services enabled. The app does not store this nor any personal data outside of your iOS device."
                config.image = UIImage(systemName: "location.fill")
                config.baseBackgroundColor = .systemBlue
                config.baseForegroundColor = .white
            case 2:
                obImageView.image = UIImage(named: "mapViewMockup2")
                obButton.setTitle("Continue", for: .normal)
                obTextLabel.text = "We're almost there!"
                obTextLabel.textAlignment = .center
                config.image = UIImage(systemName: "location.fill")
                config.baseBackgroundColor = .systemBlue
                config.baseForegroundColor = .white
            case 3:
                obImageView.image = UIImage(systemName: "clock.badge")
                obImageView.isHidden = true
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
                obTitleLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                obTitleLabel.centerYAnchor.constraint(equalTo: pageView.topAnchor, constant: 40),
                
                obImageView.widthAnchor.constraint(equalToConstant: pageView.frame.width - 70),
                obImageView.heightAnchor.constraint(equalToConstant: pageView.frame.width - 70),
                obImageView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                obImageView.centerYAnchor.constraint(equalTo: obTitleLabel.bottomAnchor, constant: 160),
                
                obTextLabel.widthAnchor.constraint(equalToConstant: pageView.frame.width - 60),
                obTextLabel.topAnchor.constraint(equalTo: obImageView.bottomAnchor, constant: 10),
                obTextLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                
                obButton.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
                obButton.bottomAnchor.constraint(equalTo: pageView.bottomAnchor, constant: -20)
            ])
        }
        
//        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 4, height: 0)
        scrollView.contentSize = CGSize(width: 0, height: holderView.frame.size.height * 4)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
    }
    
    func slidePage(button: UIButton) {
//        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        scrollView.setContentOffset(CGPoint(x: 0, y: holderView.frame.size.height * CGFloat(button.tag)), animated: true)
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



