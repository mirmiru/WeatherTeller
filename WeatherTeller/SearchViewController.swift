//
//  SearchViewController.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-25.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    var temp : [String] = ["Example1", "Example2", "Example3"]
    var results : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Search Function
    @IBAction func search(_ sender: Any) {
        print("Button clicked")
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Lund&units=metric&APPID=7edad7684e284fcb9d65d40572da3930") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler:
            { (data : Data?, response : URLResponse?, error : Error?) in
                //print("Got response.")
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
                                    if let temperature = main["temp"] {
                                        print(temperature)
                                    } else {
                                        print("No temp key found")
                                    }
                                } else {
                                    print("Can't find main.")
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
            print("Sending request.")
        } else {
            print("Bad url.")
        }
    }
    
    //MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lookUpCell", for: indexPath) as! SearchTableViewCell
        cell.locationName.text = results[indexPath.row]
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
