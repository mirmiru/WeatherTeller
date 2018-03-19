//
//  WeatherTellerUiViewController.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-17.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit


class WeatherTellerUiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var locations : [Location] = []
    //var locationsToDisplay : [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locations = createArray()
        // Do any additional setup after loading the view.
        tableView.reloadData()
    }
    
    //DUMMY DATA
    func createArray() -> [Location] {
        var tempLocations: [Location] = []
        
        let loc1 = Location(weatherIcon: #imageLiteral(resourceName: "sun"), title: "Gothenburg", weatherExplanation: "Sunny", degrees: "19\u{00B0}")
        let loc2 = Location(weatherIcon: #imageLiteral(resourceName: "sun"), title: "Helsinki", weatherExplanation: "Sunny", degrees: "15°")
        
        tempLocations.append(loc1)
        tempLocations.append(loc2)
        
        return tempLocations
    }
    
    //Filter favorites
    /*
    func loadFavorites() {
        for location is favoriteLocations where location.favorite == true {
            locationsToDisplay.append(location)
        }
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Return count of favorites array:
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = locations[indexPath.row]
        //let location = locationsToDisplay[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain", for: indexPath) as! MainTableViewCell
        
        cell.setLocationInfo(location: location)
        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
