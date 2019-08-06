//
//  ViewController.swift
//  WeatherAPI
//
//  Created by IMCS2 on 8/5/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let firstStrUrl = "http://api.openweathermap.org/data/2.5/weather?q="
    let secondStrUrl = "&appid=ca11358a1fdef72a3c2434cc40c1e4f8"
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    @IBAction func getWeatherButton(_ sender: Any) {
        
        var combinedstrUrl = firstStrUrl + cityNameTextField.text! + secondStrUrl
       var trueUrl = combinedstrUrl.replacingOccurrences(of: " ", with: "+")
        print(combinedstrUrl)
        
        
        let url = URL(string: trueUrl)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                if let unwrappedData = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                       // print((jsonResult?.count)!)
                        if((jsonResult?.count)!==2){
                            DispatchQueue.main.async {
                            self.ResultLabel.text = "enter a valid city name"
                                self.ResultLabel.textColor = .red
                            }
                        } else {
                     //   print(jsonResult!["name"]!)
                        
                        let weather = jsonResult?["weather"] as? NSArray
                      //  print(weather)
                        let getArray = weather?[0] as? NSDictionary
                        
                    //    print(getArray)
                        let getDesc = getArray?["description"] as? String
                    //    print(getDesc)
                        DispatchQueue.main.async {
                        self.ResultLabel.text = getDesc
                        self.ResultLabel.textColor = .black
                        }
                        }
                    }catch {
                        print("error in fetching")
                    }
                    
                }
            }
        }
        task.resume()
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "weatherApiimage.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
   


}

