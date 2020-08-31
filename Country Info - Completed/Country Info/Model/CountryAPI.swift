//1. Create URL
//2. Create URL Session
//3. Create a task
//4. Start / Resume the task

import Foundation

protocol CountryAPIDelegate {
    func didRetrieveCountryInfo(country: Country)
}


class CountryAPI {
    
    var delegate: CountryAPIDelegate?
    let urlBaseString="https://restcountries.eu/rest/v2/name/"
    
    func fetchData(countryName: String){
        let urlString="\(urlBaseString)\(countryName)"
        //1. create URL
        
        if let url=URL(string: urlString) {
        
        //2. create URL session
        
        let session=URLSession(configuration: .default)
        
        //3. create Task
        
        let task=session.dataTask(with: url, completionHandler: taskHandler(data:urlResponse:error:))
        
        
        //4. start / resum task
        
        task.resume()
            
        }else {
            print ("error fetching data")
        }
        
    }
    
    func taskHandler(data: Data?, urlResponse: URLResponse?, error: Error?)->Void{
        
        do {
        
            let countries:[Country]=try JSONDecoder().decode([Country].self, from: data!)
            let firstCountry=countries[0]
            delegate?.didRetrieveCountryInfo(country: firstCountry)
            
            
        }catch {
            print (error)
        }





        //let dataString=String(data: data!, encoding: .utf8)
        //delegate?.didRetrieveCountryInfo(countryInfo: dataString)
        //print (dataString)
        
    }
    
    
    
}
