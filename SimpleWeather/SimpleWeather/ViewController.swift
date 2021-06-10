//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Vladimir Vaskin on 10.06.2021.
//

import UIKit
import Metaweather

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    let restService = RestService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        if let text = textField.text, !text.isEmpty {

            restService.currentWeather(location: text) { message in
                guard message != nil else { return }
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Погода", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

