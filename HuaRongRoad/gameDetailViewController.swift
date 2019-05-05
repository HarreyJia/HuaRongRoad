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

    var row = 5
    var column = 4
    var itemDictionary = [String:SliderView]()
    var itemWidth: Int!
    var emptyBlock: SliderView!
    let gap = 8
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemWidth = (Int(view.frame.size.width) - gap) / column
        containerView.snp.makeConstraints { (make) in
            make.width.equalTo(Float(itemWidth) * Float(column))
            make.height.equalTo(Float(itemWidth) * Float(row))
            make.center.equalTo(view)
        }
        
        let item = LordSlider.init(frame: CGRect(x: (2 - 1) % column * itemWidth, y: (2 - 1) / column * itemWidth, width: itemWidth, height: itemWidth))
        item.setTitle(title: 1)
        item.width = itemWidth
        item.row = row
        item.column = column
        item.updateCoordinate(coor: Coordinate(x: (2 - 1) % column, y: (2 - 1) / column))
        containerView.addSubview(item)
//            if index == column * row {
//                item.alpha = 0
//                emptyBlock = item;
//            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "Home")
        self.present(homeVC, animated: true, completion: nil)
    }
}
