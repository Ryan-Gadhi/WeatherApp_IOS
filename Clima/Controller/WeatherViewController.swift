//
//  ViewController.swift
//  Clima
//
//  Copyright © Ryan Gadhi
//  intial setup by AppBrewery
//
import UIKit
import CoreLocation
//MARK: -Main WeatherViewController Class
class WeatherViewController: UIViewController{
    
   
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self // don't forget this again!
        updateLocationToGPS()
        
        
    }
    
    
    
}

//MARK: -LocationAccess
extension WeatherViewController: CLLocationManagerDelegate{
    func updateLocationToGPS(){
        // CoreLocation code
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func locationIconPressed(_ sender: Any) {
        updateLocationToGPS()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.fetchWeather(lat: lat, long: long)
        }
        
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("The user refused to grant the location ")
    }
}
    
    
    


//MARK: -UITextFieldDelage Section
extension WeatherViewController:  UITextFieldDelegate{
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
    
    @IBAction func searchIconPressed(_ sender: Any) {
        
        // the following endEditing function sends a request to the deligate and calls textFieldShouldEndEditing, a logic resides there to approve or disapprove this selection
        searchTextField.endEditing(true)
    }
}

//MARK: -WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate {
    
    func weatherDidUpdate(_ weatherModel: WeatherModel) {
        DispatchQueue.main.async { // why is this a clousre
            self.cityLabel.text =  weatherModel.cityName
            self.temperatureLabel.text = weatherModel.roundedTemp
            self.conditionImageView.image = UIImage(systemName:  weatherModel.iconName)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}


