//
// SettingsBundle
//
//  An exercise file for iOS Development Tips Weekly
//  by Steven Lipton (C)2018, All rights reserved
//  For videos go to http://bit.ly/TipsLinkedInLearning
//  For code go to http://bit.ly/AppPieGithub
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var favoritePizza: UILabel!
    let defaults = UserDefaults.standard
    @IBAction func displayDefaults(){
        
        var text = "" // initialize a string to place the pizza.
        
        // Add the Multi Value here
        let size = defaults.integer(forKey: "size_preference")
        text += String(format: "%i\" ", size)
        
        //A switch uses .bool(for:key)
        if defaults.bool(forKey: "panPizza_preference"){
            text += "Deep Dish Pizza \n"
        }else {
            text += "Thin crust\n"
        }
        // Text uses .string(for:key)! which can be nil, so unwrap it!
        if let toppings = defaults.string(forKey: "toppings_preference"){
            text += toppings
        }
        favoritePizza.text = text
    }
    
    @IBAction func launchSettings(_ sender: UIButton) {
       settingsLaunch()
    }
    
    func settingsLaunch(){
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString){
            UIApplication.shared.open(appSettingsURL, options: [:]) { (success) in
                if !success{
                    print("Unable to launch settings")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.register(defaults: [String:Any]())
        NotificationCenter.default.addObserver(self, selector: #selector(displayDefaults), name: UserDefaults.didChangeNotification, object: nil)
        displayDefaults()
    }

}

