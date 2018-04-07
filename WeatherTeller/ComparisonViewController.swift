//
//  ComparisonViewController.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-04-06.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit
import GraphKit

class ComparisonViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, GKBarGraphDataSource {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableview: UITableView!
    
    @IBOutlet weak var locationA: UILabel!
    @IBOutlet weak var locationB: UILabel!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var temperatureGraph: GKBarGraph!
    
    var responseArray = [LocationResponse]()
    var locAIsSet = false
    var locBIsSet = false
    
    var locAData : LocationResponse!
    var locBData : LocationResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchTableview.delegate = self
        
        //Graph
        temperatureGraph.dataSource = self
    }
    
    @IBAction func findLocation(_ sender: Any) {
        responseArray.removeAll()
        if let safeString = searchTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "http://api.openweathermap.org/data/2.5/find?q=\(safeString)&units=metric&APPID=7edad7684e284fcb9d65d40572da3930") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let actualError = error {
                    print("Error: \(actualError).")
                } else {
                    if let actualData = data {
                        let decoder = JSONDecoder()
                        do {
                            let weatherResponse = try decoder.decode(MultipleLocations.self, from: actualData)
                            for location in weatherResponse.list {
                                self.responseArray.append(location)
                                DispatchQueue.main.async {
                                    self.searchTableview.reloadData()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetA(_ sender: Any) {
        locationA.text?.removeAll()
        locAIsSet = false
    }
    
    @IBAction func resetB(_ sender: Any) {
        locationB.text?.removeAll()
        locBIsSet = false
    }
    
    @IBAction func compare(_ sender: Any) {
        temperatureGraph.draw()
        if locAIsSet && locBIsSet {
            print("Can compare")
            print(locAData)
            print(locBData)
        } else {
            print("Choose two locations")
            showAlert()
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "Please select two locations.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - GRAPH
    func numberOfBars() -> Int {
        return 6
    }
    
    func valueForBar(at index: Int) -> NSNumber! {
        switch index {
        case 0:
            return locAData.main.temp as! NSNumber
        case 1:
            return locBData.main.temp as! NSNumber
        case 2:
            return locAData.wind.speed as! NSNumber
        case 3:
            return locBData.wind.speed as! NSNumber
        case 4:
            return calculateRealFeel(location: locAData) as! NSNumber
        case 5:
            return calculateRealFeel(location: locBData) as! NSNumber
        default:
            return 0
        }
    }
    
    func titleForBar(at index: Int) -> String! {
        switch index {
        case 0...1:
            return "TEMP"
        case 2...3:
            return "WIND"
        case 4...5:
            return "FEEL"
        default:
            return "?"
        }
    }
    
    func colorForBar(at index: Int) -> UIColor! {
        if index%2==0 {
            return UIColor.red
        } else {
            return UIColor.green
        }
    }
    
    // MARK: - TABLE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableview.dequeueReusableCell(withIdentifier: "comparisonCell", for: indexPath) as! ComparisonTableViewCell
        cell.compLocationLabel.text = "\(responseArray[indexPath.row].name), \(responseArray[indexPath.row].sys.country)"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = tableView.cellForRow(at: indexPath)! as UITableViewCell
        let text = selection.textLabel?.text
        if !locAIsSet {
            locAData = responseArray[indexPath.row]
            locationA.text = text
            locAIsSet = true
        } else {
            locationB.text = text
            locBData = responseArray[indexPath.row]
            locBIsSet = true
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
