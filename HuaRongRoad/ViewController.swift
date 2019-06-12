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
    
    @IBAction func goUserHome(_ sender: Any) {
        
        UserDefaults().setValue(nameInput.text, forKey: "userName")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "Home")
        self.present(homeVC, animated: true, completion: nil)
    }
}
