//
//  MapViewController.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 01/09/2022.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var weatherMap: MKMapView!
    @IBOutlet weak var weatherNowOutlet: WeatherNowView!
    @IBOutlet weak var weatherLaterOutlet: LaterTodayView!
    @IBOutlet weak var mapWrapper: UIView!
    @IBOutlet weak var segmentedCollectionView: CollectionView!
    @IBOutlet weak var sunriseOutlet: SunriseView!
    
    var defaults = UserDefaults.standard
    
    let locationManager = CLLocationManager()
    let button = UIButton(type: .custom)
    var searchLocation = CLLocationCoordinate2D()
    
    var weatherHandler = WeatherHandler()
    var weatherForecast = [Timeseries]()
    var sunrise = [Location]()

    let geocoder = CLGeocoder()
    var userLocation = CLLocationCoordinate2D()
    let instituteLocation = CLLocationCoordinate2D(latitude: 59.94263, longitude: 10.72056)
    
    var didLoadMap: Bool = false
	
	var formatter = StringFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherMap.mapType = .satellite
        weatherMap.centerCoordinate = instituteLocation
        weatherMap.setRegion(MKCoordinateRegion(center: instituteLocation, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
        self.dismissKeyboard()
        weatherMap.delegate = self
        weatherHandler.delegate = self
        segmentedCollectionView.collectionView.dataSource = self
        styleView(views: [weatherNowOutlet, backButton, searchField, mapWrapper, weatherMap, weatherLaterOutlet, segmentedCollectionView, sunriseOutlet])
        setupButton()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//            if manager.authorizationStatus == .authorizedWhenInUse {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    self.locationManager.requestAlwaysAuthorization()
//                }
//            }
//        }
//    }
    
    //MARK: Method to show onboardingVC
    override func viewDidLayoutSubviews() {
        if NewUserCheck.shared.isNewUser() {
            let onboardingVC = storyboard?.instantiateViewController(withIdentifier: "onboarding") as! OnboardingViewController
            onboardingVC.modalPresentationStyle = .fullScreen
            present(onboardingVC, animated: true)
        } else {
            if !didLoadMap {
                loadMap()
                didLoadMap = true
            }
        }
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        weatherHandler.fetchWeather(latitude: lat, longitude: lon)
    }
    func loadMap() {
        weatherMap.removeAnnotations(weatherMap.annotations)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func returnOnKeyboardTapped(_ sender: Any) {
        findCity()
        hideKeyboard()
    }
    
    @IBAction func backTapped(_ sender: Any) {
        loadMap()
        searchField.text = ""
        hideKeyboard()
    }
    
    func setupButton() {
        button.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        var config = UIButton.Configuration.borderless()
        config.buttonSize = .medium
        button.tintColor = UIColor.label
        button.configuration = config
        searchField.rightView = button
        searchField.rightViewMode = .whileEditing
        button.addTarget(self, action: #selector(findCity), for: .touchUpInside)
    }
    
    @objc func findCity() {
        geocoder.geocodeAddressString(searchField.text ?? "") { [self] (placemarks, error) in
            let placemarks = placemarks
            let location = placemarks?.first?.location
            hideKeyboard()
            if (location != nil) {
                searchLocation = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
                fetchWeather(lat: (location?.coordinate.latitude)!, lon: (location?.coordinate.longitude)!)
                userLocation = searchLocation
            } else { return }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        userLocation = location.coordinate
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("long: \(location.coordinate.longitude), lat: \(location.coordinate.latitude)")
            searchLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        fetchWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        print(weatherForecast.count)
    }
    
    func placePin(here: CLLocationCoordinate2D, sub: String) {
        let initPin = MKPointAnnotation()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: here.latitude, longitude: here.longitude)) { (placemarks, error) in
            let placemarks = placemarks
            let location = placemarks?.first?.location
            if (location != nil) {
                placemarks?.forEach { (placemark) in
                    if let city = placemark.locality { initPin.title = city }
                }
            } else { return }
        }
        initPin.subtitle = "\(sub)°"
        initPin.coordinate = here
        weatherMap.addAnnotation(initPin)
        weatherMap.centerCoordinate = CLLocationCoordinate2D(latitude: initPin.coordinate.latitude + 0.002, longitude: initPin.coordinate.longitude)
        weatherMap.selectAnnotation(initPin, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = weatherMap.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.set(image: (UIImage(systemName: "circle.dashed") ?? UIImage(systemName: "circle.dashed"))!, with: .white)
        annotationView?.frame = CGRect(x: 0, y: 0, width: 52, height: 50)
        annotationView?.displayPriority = .required
        return annotationView
    }
}

extension MKAnnotationView {
    public func set(image: UIImage, with color : UIColor) {
        let view = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        view.tintColor = color
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        guard let graphicsContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.75
        view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        view.layer.shadowRadius = 1.5
        view.layer.render(in: graphicsContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = image
    }
}
