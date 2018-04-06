//
//  WeatherTellerUiViewController.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-17.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit


class WeatherTellerUiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var favorites : [Int] = []
    var flag = 0
    var favoriteLocations : [LocationResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flag = 0
        favorites = loadData()
        if foundFavorites(array: favorites) {
            print(favorites)
            loadFavorites()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("VDA: Saved values: \(loadData().count)")
        print("VDA: Favorites: \(favoriteLocations.count)")
        
        if loadData().count > favoriteLocations.count && flag>0 {
            favorites = loadData()
            loadFavorites()
        }
        flag += 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadData().count
    }
    
    func foundFavorites(array: [Int]) -> Bool {
        if array.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        if favoriteLocations.count > 0 {
            print("Found favorites! \(favoriteLocations.count)")
            cell.locationLabel.text = favoriteLocations[indexPath.row].name
            //cell.degreesLabel.text = String(format: "\(favoriteLocations[indexPath.row].main.temp) ℃")
            cell.degreesLabel.text = String(format: "%.1f ℃", favoriteLocations[indexPath.row].main.temp)
        } else {
            print("No favorites found.")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selection: UITableViewCell = tableView.cellForRow(at: indexPath)!
    }
    
    func loadFavorites() {
        print(favorites)
        for i in favorites {
            getWeather(locationId: i)
        }
    }
    
    func getWeather(locationId: Int) {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=\(locationId)&units=metric&APPID=7edad7684e284fcb9d65d40572da3930") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                if let actualError = error {
                    print("Error: \(actualError).")
                } else {
                    if let actualData = data {
                        let decoder = JSONDecoder()
                        do {
                            let weatherResponse = try decoder.decode(LocationResponse.self, from: actualData)
                            //TEST
                            //print("Found favorite: \(weatherResponse.name)")
                            //END TEST
                            self.favoriteLocations.append(weatherResponse)
                            print(self.favoriteLocations.count)
                            
                            DispatchQueue.main.async {
                                    self.tableView.reloadData()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destination as? DetailViewController {
            destination.localWeather = favoriteLocations[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
