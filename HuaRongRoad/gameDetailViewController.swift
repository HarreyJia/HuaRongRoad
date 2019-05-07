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
    var emptyBlock1: SliderView!
    var emptyBlock2: SliderView!
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
        item.setTitle(title: "曹操")
        item.width = itemWidth
        item.row = row
        item.column = column
        item.updateCoordinate(coor: Coordinate(x: (2 - 1) % column, y: (2 - 1) / column))
        containerView.addSubview(item)
        
        let generalList: [Int: String] = [1: "张飞", 4: "赵云", 9: "马超", 12: "黄忠"]
        for item in generalList {
            let generalItem = GeneralSlider.init(frame: CGRect(x: (item.key - 1) % column * itemWidth, y: (item.key - 1) / column * itemWidth, width: itemWidth, height: itemWidth))
            generalItem.setTitle(title: item.value)
            generalItem.width = itemWidth
            generalItem.row = row
            generalItem.column = column
            generalItem.updateCoordinate(coor: Coordinate(x: (item.key - 1) % column, y: (item.key - 1) / column))
            containerView.addSubview(generalItem)
        }
        
        let GuanYuitem = GuanYuSlider.init(frame: CGRect(x: (10 - 1) % column * itemWidth, y: (10 - 1) / column * itemWidth, width: itemWidth, height: itemWidth))
        GuanYuitem.setTitle(title: "关羽")
        GuanYuitem.width = itemWidth
        GuanYuitem.row = row
        GuanYuitem.column = column
        GuanYuitem.updateCoordinate(coor: Coordinate(x: (10 - 1) % column, y: (10 - 1) / column))
        containerView.addSubview(GuanYuitem)
        
        let pawnList: [Int] = [14, 15, 17, 20]
        for location in pawnList {
            let pawnItem = PawnSlider.init(frame: CGRect(x: (location - 1) % column * itemWidth, y: (location - 1) / column * itemWidth, width: itemWidth, height: itemWidth))
            pawnItem.setTitle(title: "卒")
            pawnItem.width = itemWidth
            pawnItem.row = row
            pawnItem.column = column
            pawnItem.updateCoordinate(coor: Coordinate(x: (location - 1) % column, y: (location - 1) / column))
            containerView.addSubview(pawnItem)
        }
        
    
        let emptyItem = SliderView.init(frame: CGRect(x: (18 - 1) % column * itemWidth, y: (18 - 1) / column * itemWidth, width: itemWidth, height: itemWidth))
        emptyItem.alpha = 0
        emptyItem.width = itemWidth
        emptyItem.row = row
        emptyItem.column = column
        emptyItem.updateCoordinate(coor: Coordinate(x: (18 - 1) % column, y: (18 - 1) / column))
        emptyBlock1 = emptyItem

        let emptyItem2 = SliderView.init(frame: CGRect(x: (19 - 1) % column * itemWidth, y: (19 - 1) / column * itemWidth, width: itemWidth, height: itemWidth))
        emptyItem2.alpha = 0
        emptyItem2.width = itemWidth
        emptyItem2.row = row
        emptyItem2.column = column
        emptyItem2.updateCoordinate(coor: Coordinate(x: (19 - 1) % column, y: (19 - 1) / column))
        emptyBlock2 = emptyItem2
    }
    
    func judgeEmptyLocation() -> String {
        
        print(emptyBlock1.coordinate.x, emptyBlock1.coordinate.y)
        print(emptyBlock2.coordinate.x, emptyBlock2.coordinate.y)
        
        if emptyBlock1.coordinate.x == emptyBlock2.coordinate.x && emptyBlock1.coordinate.y + 1 == emptyBlock2.coordinate.y || emptyBlock1.coordinate.y == emptyBlock2.coordinate.y + 1 {
            return "vertical"
        } else if emptyBlock1.coordinate.y == emptyBlock2.coordinate.y && emptyBlock1.coordinate.x + 1 == emptyBlock2.coordinate.x || emptyBlock1.coordinate.x == emptyBlock2.coordinate.x + 1 {
            return "horizontal"
        } else {
            return "separated"
        }
    }
    
    func move(_ item: SliderView) -> Bool {
        
        let type = item.titleLabel.text
        
        if type == "曹操" {
            if judgeEmptyLocation() == "separated" {
                return false
            }
        } else if type == "张飞" || type == "赵云" || type == "马超" || type == "黄忠" {
//            if judgeEmptyLocation() == "separated" || judgeEmptyLocation() == "horizontal" {
//                return false
//            }
        } else if type == "关羽" {
//            if judgeEmptyLocation() == "separated" || judgeEmptyLocation() == "vertical" {
//                return false
//            }
        }
        
        if item.canMove(emptyItem1: emptyBlock1, emptyItem2: emptyBlock2, type: judgeEmptyLocation()) {
            return true
        } else {
            return false
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            if let item = touch.view as? SliderView {
                if move(item) {
                    print("Can Move")
                } else {
                    print("Cannot Move")
                }
                // checkisSuccessed()
            }
            break
        }
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
