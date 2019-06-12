//
//  ViewController.swift
//  HuaRongRoad
//
//  Created by Harrey Jia on 2019/5/1.
//  Copyright © 2019 Harrey Jia. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userLogin: UIButton!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLogin.layer.cornerRadius = 10
        
        nameInput.delegate = self
        nameInput.returnKeyType = UIReturnKeyType.done
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardWillChange(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameInput.resignFirstResponder()
        self.bottomConstraint.constant = 100
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
        self.bottomConstraint.constant = 100
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            self.bottomConstraint.constant = intersection.height
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIView.AnimationOptions(rawValue: curve), animations: {
                            
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
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
