//
//  ViewController.swift
//  Country Info
//
//  Created by Muhamed Alkhatib on 26/08/2020.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate=self
        countryAPI.delegate=self
        locationManager.delegate=self
        
        // Do any additional setup after loading the view.
    }
    
    var locationManager=CLLocationManager()
    var geoCoder=CLGeocoder()
    
    var countryAPI=CountryAPI()

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        updateUI()
        
        
        
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
    }
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var populationLabel: UILabel!
    
    
    func updateUI () {
        countryAPI.fetchData(countryName:searchTextField.text!)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateUI()
        return true
    }
}

extension ViewController: CountryAPIDelegate {
    
    func didRetrieveCountryInfo(country: Country) {
        print(country)
        
        DispatchQueue.main.async {
            self.countryLabel.text=country.name
            self.capitalLabel.text=country.capital
            self.regionLabel.text=country.region
            self.populationLabel.text=String(country.population)
        }
        
        
        
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print (locations[0])
        let location=locations.last
        
        geoCoder.reverseGeocodeLocation(location!) { (places, error) in
//            print(places?.last?.isoCountryCode)
//            print(places?.last?.country)
            
              let cName=places?.last?.country!
            
              self.countryAPI.fetchData(countryName: cName!)
            
            
            
        }
        
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
    
    
}
