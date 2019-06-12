//
//  userHome.swift
//  HuaRongRoad
//
//  Created by Harrey Jia on 2019/6/11.
//  Copyright © 2019 Harrey Jia. All rights reserved.
//

import UIKit

class userHome: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    var nickName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = UserDefaults().string(forKey: "userName") ?? ""
    }
    
    
    @IBAction func gameDidStart(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "GameDetail")
        self.present(homeVC, animated: true, completion: nil)
    }
}
