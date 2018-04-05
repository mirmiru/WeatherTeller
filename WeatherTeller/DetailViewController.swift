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
    @IBOutlet weak var uvIcon: UIImageView!
    
    @IBOutlet weak var sweaterButton: UIButton!
    @IBOutlet weak var mittenButton: UIButton!
    
    @IBOutlet weak var iconTextView: UITextView!
    
    var localWeather : LocationResponse!
    var sweaterText : String!
    var mittenText : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeatherData()
        calculateRealFeel()
    }
    
    func loadWeatherData() {
        locationLabel.text = localWeather.name
        temperatureLabel.text = String(format: "%.1f", localWeather.main.temp)
        windLabel.text = String(localWeather.wind.speed)
        realfeelLabel.text = String(format: "%.1f", calculateRealFeel())
        
        getRecommendations()
    }
    
    func calculateRealFeel() -> Double {
        let temp = localWeather.main.temp
        let wind = localWeather.wind.speed
        let twc = 13.12+(0.6215 * temp) - 11.37 * pow(wind, 0.16) + 0.3965 * pow(temp, 0.16)
        print(twc)
        return twc
    }
    
    func getRecommendations() {
        if shouldBringSweather(temp: localWeather.main.temp) {
            sweaterButton.setImage(#imageLiteral(resourceName: "sweater"), for: UIControlState.normal)
            sweaterText = "It's cold!"
        } else {
            sweaterText = "It's not that cold."
        }
        
        if shouldBringMittens(temp: localWeather.main.temp) {
            mittenButton.setImage(#imageLiteral(resourceName: "mitten"), for: UIControlState.normal)
            mittenText = "You should bring a pair of mittens."
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        let id = localWeather.id
        saveData(id: id)
        print("Saved to favorites")
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
