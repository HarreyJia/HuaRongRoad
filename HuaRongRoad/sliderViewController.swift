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
    
    var isCorrect:Bool {
        if count % row == coordinate.x && count / row == coordinate.y {
            return true
        }
        return false
    }

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
//        count = title - 1
    }
    
    func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: width, height: width)
    }
    
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
    
    override func move(to destination: SliderView) {
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
}

class GeneralSlider: SliderView {
    
    override func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: width, height: 2 * width)
    }
    
    override func move(to destination: SliderView) {
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
}

class GuanYuSlider: SliderView {
    
    override func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: 2 * width, height: width)
    }
    
    override func move(to destination: SliderView) {
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
}

class PawnSlider: SliderView {
    
    override func move(to destination: SliderView) {
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
}

