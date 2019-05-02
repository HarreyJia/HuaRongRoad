//
//  gameDetailViewController.swift
//  HuaRongRoad
//
//  Created by Harrey Jia on 2019/5/2.
//  Copyright © 2019 Harrey Jia. All rights reserved.
//

import UIKit
import SnapKit

class gameDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "Home")
        self.present(homeVC, animated: true, completion: nil)
    }
}
