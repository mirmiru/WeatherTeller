//
//  SearchTableViewController.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-25.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var city = ["Helsinki", "Gothenburg", "Lund", "Malmö", "Malund"]
    var searchResult : [String] = []
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text?.lowercased() {
            //Sök i API - skicka in text som argument
            getWeather()
        } else {
            searchResult = []
        }
    }
    
    func getWeather() {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=London&units=metric&APPID=7edad7684e284fcb9d65d40572da3930") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler:
            { (data : Data?, response : URLResponse?, error : Error?) in
                //print("Got response from server.")
                
                if let actualError = error {
                    print(actualError)
                } else {
                    if let actualData = data {
                        let options = JSONSerialization.ReadingOptions()
                        do {
                            let parsed = try JSONSerialization.jsonObject(with: actualData, options: options)
                            //print(parsed)
                            
                            if let dict = parsed as? [String: AnyObject] {
                                if let main = dict["main"] {
                                    print(main)
                                } else {
                                    print("Can't find main key.")
                                }
                            } else {
                                print("Can't create dict.")
                            }
                        } catch {
                            print("Failed to parse JSON.")
                        }
                    } else {
                        print("No data received.")
                    }
                }
            })
            task.resume()
            print("Sending request")
        } else {
            print("Bad url string")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.text = city[indexPath.row]
        return cell
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
