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
    
    @IBOutlet weak var umbrellaIcon: UIImageView!
    
    @IBOutlet weak var sweaterButton: UIButton!
    @IBOutlet weak var mittenButton: UIButton!
    @IBOutlet weak var spfButton: UIButton!
    
    @IBOutlet weak var iconTextView: UITextView!
    
    var localWeather : LocationResponse!
    var sweaterText : String!
    var mittenText : String!
    var uvIndex : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUV(lat: localWeather.coord.lat, lon: localWeather.coord.lon)
        loadWeatherData()
    }
    
    func loadWeatherData() {
        locationLabel.text = localWeather.name
        temperatureLabel.text = String(format: "%.1f ℃", localWeather.main.temp)
        print(String(format: "%.1f ℃", localWeather.main.temp))
        windLabel.text = String("\(localWeather.wind.speed) m/s")
        realfeelLabel.text = String(format: "%.1f ℃", calculateRealFeel())
        getRecommendations()
    }
    
    func calculateRealFeel() -> Double {
        let temp = localWeather.main.temp
        let wind = localWeather.wind.speed
        let twc = 13.12+(0.6215 * temp) - 11.37 * pow(wind, 0.16) + 0.3965 * pow(temp, 0.16)
        return twc
    }
    
    func getRecommendations() {
        if shouldBringSweather(temp: localWeather.main.temp) {
            sweaterButton.setImage(#imageLiteral(resourceName: "sweater"), for: UIControlState.normal)
            sweaterText = String(format: "The temperature feels like %.1f degrees, so you're going to need a sweater.", calculateRealFeel())
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
        iconTextView.text = sweaterText
    }
    
    @IBAction func mittenClicked(_ sender: Any) {
        iconTextView.text = mittenText
    }
    
    @IBAction func spfClicked(_ sender: Any) {
        //getUV(lat: localWeather.coord.lat, lon: localWeather.coord.lon)
        iconTextView.text = shouldWearSunblock(uv: uvIndex).spfRecText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        let id = localWeather.id
        saveData(id: id)
        print("Saved to favorites")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
