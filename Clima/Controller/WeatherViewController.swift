//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self // don't forget this again!
        
    }
    
    @IBAction func searchIconPressed(_ sender: Any) {

        // the following endEditing function sends a request to the deligate and calls textFieldShouldEndEditing, a logic resides there to approve or disapprove this selection
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Please Provide a City!"
            return false
        }else{
            return true
        }
        
    }
    
    // after clicking the return button this function gets
    // triggered
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.endEditing(true)
        
        return true
    }
    
    // after the keyboard dissappears this gets called
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        /*
         use the weather api here to get the data and update the label
         
         */
        if let typedCity = textField.text{
        weatherManager.fetchWeather(of: typedCity)
        }
        textField.text = ""
        textField.placeholder = "Type Another City"
    }
    

}

