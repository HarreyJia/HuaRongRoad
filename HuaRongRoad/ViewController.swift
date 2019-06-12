//
//  ViewController.swift
//  HuaRongRoad
//
//  Created by Harrey Jia on 2019/5/1.
//  Copyright © 2019 Harrey Jia. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userLogin: UIButton!
    @IBOutlet weak var nameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLogin.layer.cornerRadius = 10
    }
    
    func validateName() -> Bool {
        if (nameInput.text == "") {
            return false
        }
        return true
    }
    
    @IBAction func goUserHome(_ sender: Any) {
        
        if (!self.validateName()) {
            UIAlertController.showAlert(message: "Nickname cannot be empty!")
            return
        }
        
        UserDefaults().setValue(nameInput.text, forKey: "userName")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "Home")
        self.present(homeVC, animated: true, completion: nil)
    }
}


extension UIAlertController {
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
    
    static func showConfirm(message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to Home", style: .cancel))
        alert.addAction(UIAlertAction(title: "Continue playing", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
    
    static func showConfirm(message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirm(message: message, in: vc, confirm: confirm)
        }
    }
}
