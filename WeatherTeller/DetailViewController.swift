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
    @IBOutlet weak var shirtIcon: UIImageView!
    @IBOutlet weak var mittenIcon: UIImageView!
    @IBOutlet weak var uvIcon: UIImageView!
    
    @IBOutlet weak var iconTextView: UITextView!
    
    var localWeather : LocationResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabel.text = localWeather.name
        //temperatureLabel.text = localWeather.main.temp
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
