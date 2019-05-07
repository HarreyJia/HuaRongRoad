//
//  sliderViewController.swift
//  HuaRongRoad
//
//  Created by Harrey Jia on 2019/5/4.
//  Copyright © 2019 Harrey Jia. All rights reserved.
//

import UIKit

struct Coordinate: Hashable {
    var x: Int
    var y: Int
}

class SliderView: UIView {

    var coordinate: Coordinate!
    
    var row: Int!
    
    var column: Int!
    
    var count: Int!
    
    var width: Int!
    
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.orange
        titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: width, height: width)
    }
    
    func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String) -> Bool { return true }
    
    /// 判断当前滑块上下左右4个方向是否有空白地方，然后朝空白地方滑过去
    func move(to destination: SliderView) {
        if self.coordinate.x + 1 == destination.coordinate.x && self.coordinate.y == destination.coordinate.y{
            exchange(destination)
            return
        } else if self.coordinate.x - 1 == destination.coordinate.x && self.coordinate.y == destination.coordinate.y {
            exchange(destination)
            return
        }else if self.coordinate.x == destination.coordinate.x && self.coordinate.y + 1 == destination.coordinate.y {
            exchange(destination)
            return
        }else if self.coordinate.x == destination.coordinate.x && self.coordinate.y - 1 == destination.coordinate.y {
            exchange(destination)
            return
        }
    }

    func exchange(_ emtpy: SliderView) {
        swap(&(emtpy.coordinate), &(self.coordinate))
        swap(&(emtpy.frame), &(self.frame))
    }
}

class LordSlider: SliderView {
    
    override func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: 2 * width, height: 2 * width)
    }
    
    override func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String) -> Bool {
        if type == "horizontal" {
            if (self.coordinate.x == emptyItem1.coordinate.x && self.coordinate.x + 1 == emptyItem2.coordinate.x) || (self.coordinate.x == emptyItem2.coordinate.x && self.coordinate.x + 1 == emptyItem1.coordinate.x) {
                if self.coordinate.y == emptyItem1.coordinate.y + 1 || self.coordinate.y == emptyItem1.coordinate.y - 2 {
                    return true
                }
            }
        } else {
            if (self.coordinate.y == emptyItem1.coordinate.y && self.coordinate.y + 1 == emptyItem2.coordinate.y) || (self.coordinate.y == emptyItem2.coordinate.y && self.coordinate.y + 1 == emptyItem1.coordinate.y) {
                if self.coordinate.x == emptyItem1.coordinate.x + 1 || self.coordinate.x == emptyItem1.coordinate.x - 2 {
                    return true
                }
            }
        }
        return false
    }
}

class GeneralSlider: SliderView {
    
    override func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: width, height: 2 * width)
    }
    
    override func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String) -> Bool {
        if (self.coordinate.y == emptyItem1.coordinate.y && self.coordinate.y + 1 == emptyItem2.coordinate.y) || (self.coordinate.y == emptyItem2.coordinate.y && self.coordinate.y + 1 == emptyItem1.coordinate.y) {
            if self.coordinate.x == emptyItem1.coordinate.x + 1 || self.coordinate.x == emptyItem1.coordinate.x - 2 {
                return true
            }
        }

        if (self.coordinate.x == emptyItem1.coordinate.x && (self.coordinate.y == emptyItem1.coordinate.y + 1 || self.coordinate.y == emptyItem1.coordinate.y - 2)) {
            return true
        }

        if (self.coordinate.x == emptyItem2.coordinate.x && (self.coordinate.y == emptyItem2.coordinate.y + 1 || self.coordinate.y == emptyItem2.coordinate.y - 2)) {
            return true
        }
        return false
    }
}

class GuanYuSlider: SliderView {
    
    override func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: 2 * width, height: width)
    }
    
    override func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String) -> Bool {
        if (self.coordinate.x == emptyItem1.coordinate.x && self.coordinate.x + 1 == emptyItem2.coordinate.x) || (self.coordinate.x == emptyItem2.coordinate.x && self.coordinate.x + 1 == emptyItem1.coordinate.x) {
            if self.coordinate.y == emptyItem1.coordinate.y + 1 || self.coordinate.y == emptyItem1.coordinate.y - 2 {
                return true
            }
        }
        
        if (self.coordinate.y == emptyItem1.coordinate.y && (self.coordinate.x == emptyItem1.coordinate.x + 1 || self.coordinate.x == emptyItem1.coordinate.x - 2)) {
            return true
        }
        
        if (self.coordinate.y == emptyItem2.coordinate.y && (self.coordinate.x == emptyItem2.coordinate.x + 1 || self.coordinate.x == emptyItem2.coordinate.x - 2)) {
            return true
        }
        
        return false
    }
}

class PawnSlider: SliderView {
    
    override func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String) -> Bool {
        if (self.coordinate.y == emptyItem1.coordinate.y && (self.coordinate.x == emptyItem1.coordinate.x + 1 || self.coordinate.x == emptyItem1.coordinate.x - 1)) {
            return true
        }
        
        if (self.coordinate.y == emptyItem2.coordinate.y && (self.coordinate.x == emptyItem2.coordinate.x + 1 || self.coordinate.x == emptyItem2.coordinate.x - 1)) {
            return true
        }
        
        if (self.coordinate.x == emptyItem1.coordinate.x && (self.coordinate.y == emptyItem1.coordinate.y + 1 || self.coordinate.y == emptyItem1.coordinate.y - 1)) {
            return true
        }
        
        if (self.coordinate.x == emptyItem2.coordinate.x && (self.coordinate.y == emptyItem2.coordinate.y + 1 || self.coordinate.y == emptyItem2.coordinate.y - 1)) {
            return true
        }
        
        return false
    }
}

