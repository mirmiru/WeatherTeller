//
//  TestViewController.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-26.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var foundLocations : [LocationResponse] = []
    //var noLocations : [String] = []
    
    var localWeather : LocationResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        tableView.delegate = self
    }
    
    @IBAction func lookUpLocation(_ sender: Any) {
        foundLocations.removeAll()
        if let safeString = textField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
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
                                self.foundLocations.append(location)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
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
    }
    
    //MARK: - Tableview

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as! TestTableViewCell
        cell.locationLabel.text = "\(foundLocations[indexPath.row].name), \(foundLocations[indexPath.row].sys.country)"
        cell.temperatureLabel.text = String(format: "%.1f ℃", foundLocations[indexPath.row].main.temp)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundLocations.count
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection: UITableViewCell = tableView.cellForRow(at: indexPath)!
        //print(selection.textLabel?.text)
        //textField.text = selection.textLabel!.text
        //tableView.reloadData()
    }
 */

    /*
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    */
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.localWeather = foundLocations[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
