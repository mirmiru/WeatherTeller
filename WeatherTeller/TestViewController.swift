//
//  TestViewController.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-26.
//  Copyright © 2018 Milja V. All rights reserved.
//

import UIKit

struct Location : Codable {
    let id: Int
    let name: String
}

class TestViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var autoCompletePossibilities = ["Wand", "Wizard", "Test"]
    var autoComplete : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //JSON
        
        let path = Bundle.main.path(forResource: "CityList", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let cities = try JSONDecoder().decode([Location].self, from: data)
            print(cities)
        } catch {
            print("Error parsing.")
        }
        
        //END JSON
        
        textField.delegate = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Textfield
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let subString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        searchAutocompleteEntriesWithSubstring(subString: subString)
        
        return true
    }
    
    func searchAutocompleteEntriesWithSubstring(subString: String) {
        autoComplete.removeAll(keepingCapacity: false)
        for key in autoCompletePossibilities {
            let myString:NSString! = key as NSString
            let substringRange : NSRange! = myString.range(of: subString)
            if (substringRange.location == 0) {
                autoComplete.append(key)
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - Tableview
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = autoComplete[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection: UITableViewCell = tableView.cellForRow(at: indexPath)!
        textField.text = selection.textLabel!.text
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
