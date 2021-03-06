//
//  DetailViewController.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-28.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //OUTLETS
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var realfeelLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var sweaterButton: UIButton!
    @IBOutlet weak var mittenButton: UIButton!
    @IBOutlet weak var spfButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var iconTextView: UITextView!
    
    //ANIMATIONS AND DYNAMICS
    var dynamicAnimator : UIDynamicAnimator!
    var snap : UISnapBehavior!
    var push : UIPushBehavior!
    var isShowingText = false
    
    @IBOutlet weak var bgViewSweater: UIView!
    @IBOutlet weak var bgViewMitten: UIView!
    @IBOutlet weak var bgViewUv: UIView!
    @IBOutlet weak var textBgView: UIView!
    
    var localWeather : LocationResponse!
    var sweaterText : String!
    var mittenText : String!
    var uvIndex : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUV(lat: localWeather.coord.lat, lon: localWeather.coord.lon)
        loadWeatherData()
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
    }
    
    func loadWeatherData() {
        locationLabel.text = localWeather.name
        temperatureLabel.text = String(format: "%.1f ℃", localWeather.main.temp)
        windLabel.text = String("\(localWeather.wind.speed) m/s")
        realfeelLabel.text = String(format: "%.1f ℃", calculateRealFeel(location: localWeather))
        descriptionView.text = localWeather.weather[0].description
        getRecommendations()
    }
    
    func getRecommendations() {
        if shouldBringSweather(temp: localWeather.main.temp) {
            sweaterButton.setImage(#imageLiteral(resourceName: "sweater"), for: UIControlState.normal)
            sweaterText = String(format: "The temperature feels like %.1f degrees, so you're going to need a sweater.", calculateRealFeel(location: localWeather))
        } else {
            sweaterText = "It's not that cold today - enjoy!"
        }
        if shouldBringMittens(temp: localWeather.main.temp) {
            mittenButton.setImage(#imageLiteral(resourceName: "mitten"), for: UIControlState.normal)
            mittenText = "You should bring a pair of mittens to keep your hands warm!"
        } else {
            mittenText = "You don't need mittens today."
        }
    }

    @IBAction func sweaterClicked(_ sender: Any) {
        dynamics(item: sweaterButton, snapDestination: bgViewSweater)
        iconTextView.text = sweaterText
        flipAnimation(isActive: true)
    }
    
    @IBAction func mittenClicked(_ sender: Any) {
        dynamics(item: mittenButton, snapDestination: bgViewMitten)
        iconTextView.text = mittenText
        flipAnimation(isActive: true)
    }
    
    @IBAction func spfClicked(_ sender: Any) {
        dynamics(item: spfButton, snapDestination: bgViewUv)
        iconTextView.text = shouldWearSunblock(uv: uvIndex).spfRecText
        flipAnimation(isActive: true)
    }
    
    //ANIMATIONS
    func flipAnimation(isActive: Bool) {
        UIView.transition(with: textBgView, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    //DYNAMICS
    func dynamics(item: UIButton, snapDestination: UIView) {
        snap = UISnapBehavior(item: item, snapTo: snapDestination.center)
        dynamicAnimator.addBehavior(snap)
        push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.pushDirection = CGVector(dx: 0, dy: -1)
        push.magnitude = 3.0
        dynamicAnimator.addBehavior(push)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        if !saveData(id: localWeather.id) {
            showAlert()
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "Location already saved.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func getUV(lat: Double, lon: Double) {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/uvi?appid=7edad7684e284fcb9d65d40572da3930&lat=\(lat)&lon=\(lon)") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let actualError = error {
                    print("Error: \(actualError).")
                } else {
                    if let actualData = data {
                        let decoder = JSONDecoder()
                        do {
                            let uvResponse = try decoder.decode(UVResponse.self, from: actualData)
                            print("UV Index: \(uvResponse.value)")
                            self.uvIndex = uvResponse.value
                            if (self.uvIndex > 2) {
                                DispatchQueue.main.async {
                                    self.spfButton.setImage(#imageLiteral(resourceName: "spf"), for: UIControlState.normal)
                                }
                            }
                        } catch let error {
                            print("Error parsing JSON: \(error)")
                        }
                    } else {
                        print("No data received.")
                    }
                }
            })
            task.resume()
        } else {
            print("Bad URL string.")
        }
    }
}
