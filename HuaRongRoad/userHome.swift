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
    @IBOutlet weak var introText: UILabel!
    
    var nickName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introText.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        introText.numberOfLines = 0
        
        introText.text = "         The SpongeBob Escape is developed by Jia Lingxiang, a student at Nankai University's School of Software. It is based on the improvement of the Three Kingdoms Huarong Road, using the classic image of SpongeBob to play games for childhood. The basic gameplay is similar to that of the Three Kingdoms Huarong Road. You only need the SpongeBob to reach the exit."
        
        
        userName.text = UserDefaults().string(forKey: "userName") ?? ""
    }
    
    
    @IBAction func gameDidStart(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "GameDetail")
        self.present(homeVC, animated: true, completion: nil)
    }
}
