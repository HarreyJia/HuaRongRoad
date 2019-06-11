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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        let red = 173
        let green = 216
        let blue = 230
        self.backgroundColor = UIColor.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setImage(imageName: String) {
        let image = UIImage(named:imageName)
        
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addSubview(imageView)
    }
    
    func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: width, height: width)
    }
    
    func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String, direction: String) -> Bool { return true }

    func exchange(_ emtpy: SliderView) {
        swap(&(emtpy.coordinate), &(self.coordinate))
        swap(&(emtpy.frame), &(self.frame))
    }
    
    func exchange_slider(_ empty1: SliderView, _ empty2: SliderView) {}
}

class LordSlider: SliderView {
    
    override func setImage(imageName: String) {
        let image = UIImage(named:imageName)
        
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: self.frame.width * 2, height: self.frame.height * 2)
        self.addSubview(imageView)
    }
    
    override func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: 2 * width, height: 2 * width)
    }
    
    override func exchange_slider(_ empty1: SliderView, _ empty2: SliderView) {
        let x = self.coordinate.x
        let y = self.coordinate.y
        
        if empty1.coordinate.x == empty2.coordinate.x {
            if empty1.coordinate.x < x {
                self.updateCoordinate(coor: Coordinate(x: empty1.coordinate.x, y: (empty1.coordinate.y < empty2.coordinate.y) ? empty1.coordinate.y : empty2.coordinate.y))
                empty1.updateCoordinate(coor: Coordinate(x: x + 1, y: y))
                empty2.updateCoordinate(coor: Coordinate(x: x + 1, y: y + 1))
            } else {
                self.updateCoordinate(coor: Coordinate(x: x + 1, y: (empty1.coordinate.y < empty2.coordinate.y) ? empty1.coordinate.y : empty2.coordinate.y))
                empty1.updateCoordinate(coor: Coordinate(x: x, y: y))
                empty2.updateCoordinate(coor: Coordinate(x: x, y: y + 1))
            }
        } else {
            if empty1.coordinate.y < y {
                self.updateCoordinate(coor: Coordinate(x: (empty1.coordinate.x < empty2.coordinate.x) ? empty1.coordinate.x : empty2.coordinate.x, y: empty1.coordinate.y))
                empty1.updateCoordinate(coor: Coordinate(x: x, y: y + 1))
                empty2.updateCoordinate(coor: Coordinate(x: x + 1, y: y + 1))
            } else {
                self.updateCoordinate(coor: Coordinate(x: x, y: y + 1))
                empty1.updateCoordinate(coor: Coordinate(x: x, y: y))
                empty2.updateCoordinate(coor: Coordinate(x: x + 1, y: y))
            }
        }
    }
    
    override func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String, direction: String) -> Bool {
        if (self.coordinate.x == emptyItem1.coordinate.x && self.coordinate.x + 1 == emptyItem2.coordinate.x) || (self.coordinate.x == emptyItem2.coordinate.x && self.coordinate.x + 1 == emptyItem1.coordinate.x) {
            if self.coordinate.y == emptyItem1.coordinate.y + 1 && self.coordinate.y == emptyItem2.coordinate.y + 1 && direction == "up" {
                exchange_slider(emptyItem1, emptyItem2)
                return true
            }
            if self.coordinate.y == emptyItem1.coordinate.y - 2 && self.coordinate.y == emptyItem2.coordinate.y - 2 && direction == "down" {
                exchange_slider(emptyItem1, emptyItem2)
                return true
            }
        }

        if (self.coordinate.y == emptyItem1.coordinate.y && self.coordinate.y + 1 == emptyItem2.coordinate.y) || (self.coordinate.y == emptyItem2.coordinate.y && self.coordinate.y + 1 == emptyItem1.coordinate.y) {
            if self.coordinate.x == emptyItem1.coordinate.x + 1 && direction == "left" {
                exchange_slider(emptyItem1, emptyItem2)
                return true
            }
            if self.coordinate.x == emptyItem1.coordinate.x - 2 && direction == "right" {
                exchange_slider(emptyItem1, emptyItem2)
                return true
            }
        }
        return false
    }
}

class GeneralSlider: SliderView {
    
    override func setImage(imageName: String) {
        let image = UIImage(named:imageName)
        
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: self.frame.width, height: self.frame.height * 2)
        self.addSubview(imageView)
    }

    override func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: width, height: 2 * width)
    }
    
    override func exchange_slider(_ empty1: SliderView, _ empty2: SliderView) {
        let x = self.coordinate.x
        let y = self.coordinate.y
        
        self.updateCoordinate(coor: Coordinate(x: empty1.coordinate.x, y: (empty1.coordinate.y < empty2.coordinate.y) ? empty1.coordinate.y : empty2.coordinate.y))
        empty1.updateCoordinate(coor: Coordinate(x: x, y: y))
        empty2.updateCoordinate(coor: Coordinate(x: x, y: y + 1))
    }
    
    override func exchange(_ empty: SliderView) {
        let x = self.coordinate.x
        let y = self.coordinate.y
        
        if empty.coordinate.y < y {
            self.updateCoordinate(coor: Coordinate(x: empty.coordinate.x, y: empty.coordinate.y))
            empty.updateCoordinate(coor: Coordinate(x: x, y: y + 1))
        } else {
            self.updateCoordinate(coor: Coordinate(x: x, y: y + 1))
            empty.updateCoordinate(coor: Coordinate(x: x, y: y))
        }
        
    }
    
    override func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String, direction: String) -> Bool {
        if (self.coordinate.y == emptyItem1.coordinate.y && self.coordinate.y + 1 == emptyItem2.coordinate.y) || (self.coordinate.y == emptyItem2.coordinate.y && self.coordinate.y + 1 == emptyItem1.coordinate.y) {
            if self.coordinate.x == emptyItem1.coordinate.x + 1 && self.coordinate.x == emptyItem2.coordinate.x + 1 && direction == "left" {
                exchange_slider(emptyItem1, emptyItem2)
                return true
            }
            
            if self.coordinate.x == emptyItem1.coordinate.x - 1 && self.coordinate.x == emptyItem2.coordinate.x - 1 && direction == "right" {
                exchange_slider(emptyItem1, emptyItem2)
                return true
            }
        }

        if self.coordinate.x == emptyItem1.coordinate.x && self.coordinate.y == emptyItem1.coordinate.y + 1 && direction == "up" {
            exchange(emptyItem1)
            return true
        }
        
        if self.coordinate.x == emptyItem1.coordinate.x && self.coordinate.y == emptyItem1.coordinate.y - 2 && direction == "down" {
            exchange(emptyItem1)
            return true
        }

        if self.coordinate.x == emptyItem2.coordinate.x && self.coordinate.y == emptyItem2.coordinate.y + 1 && direction == "up" {
            exchange(emptyItem2)
            return true
        }
        
        if self.coordinate.x == emptyItem2.coordinate.x && self.coordinate.y == emptyItem2.coordinate.y - 2 && direction == "down" {
            exchange(emptyItem2)
            return true
        }
        
        return false
    }
}

class GuanYuSlider: SliderView {
    
    override func setImage(imageName: String) {
        let image = UIImage(named:imageName)
        
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: self.frame.width * 2, height: self.frame.height)
        self.addSubview(imageView)
    }

    override func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: 2 * width, height: width)
    }
    
    override func exchange(_ empty: SliderView) {
        let x = self.coordinate.x
        let y = self.coordinate.y

        if empty.coordinate.x < x {
            self.updateCoordinate(coor: Coordinate(x: empty.coordinate.x, y: empty.coordinate.y))
            empty.updateCoordinate(coor: Coordinate(x: x + 1, y: y))
        } else {
            self.updateCoordinate(coor: Coordinate(x: x + 1, y: y))
            empty.updateCoordinate(coor: Coordinate(x: x, y: y))
        }
        
    }
    
    override func exchange_slider(_ empty1: SliderView, _ empty2: SliderView) {
        let x = self.coordinate.x
        let y = self.coordinate.y
        
        self.updateCoordinate(coor: Coordinate(x: (empty1.coordinate.x < empty2.coordinate.x) ? empty1.coordinate.x : empty2.coordinate.x, y: empty1.coordinate.y))
        empty1.updateCoordinate(coor: Coordinate(x: x, y: y))
        empty2.updateCoordinate(coor: Coordinate(x: x + 1, y: y))
    }
    
    override func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String, direction: String) -> Bool {
        if (self.coordinate.x == emptyItem1.coordinate.x && self.coordinate.x + 1 == emptyItem2.coordinate.x) || (self.coordinate.x == emptyItem2.coordinate.x && self.coordinate.x + 1 == emptyItem1.coordinate.x) {
            if self.coordinate.y == emptyItem1.coordinate.y + 1 && self.coordinate.y == emptyItem2.coordinate.y + 1 && direction == "up" {
                exchange_slider(emptyItem1, emptyItem2)
                return true
            }
            
            if self.coordinate.y == emptyItem1.coordinate.y - 1 && self.coordinate.y == emptyItem2.coordinate.y - 1 && direction == "down" {
                exchange_slider(emptyItem1, emptyItem2)
                return true
            }
        }
        
        if self.coordinate.y == emptyItem1.coordinate.y && self.coordinate.x == emptyItem1.coordinate.x + 1 && direction == "left" {
            exchange(emptyItem1)
            return true
        }
        
        if self.coordinate.y == emptyItem1.coordinate.y && self.coordinate.x == emptyItem1.coordinate.x - 2 && direction == "right" {
            exchange(emptyItem1)
            return true
        }
        
        if self.coordinate.y == emptyItem2.coordinate.y && self.coordinate.x == emptyItem2.coordinate.x + 1 && direction == "left" {
            exchange(emptyItem2)
            return true
        }
        
        if self.coordinate.y == emptyItem2.coordinate.y && self.coordinate.x == emptyItem2.coordinate.x - 2 && direction == "right" {
            exchange(emptyItem2)
            return true
        }
        
        return false
    }
}

class PawnSlider: SliderView {
    
    override func canMove(emptyItem1: SliderView, emptyItem2: SliderView, type: String, direction: String) -> Bool {
        if self.coordinate.y == emptyItem1.coordinate.y && self.coordinate.x == emptyItem1.coordinate.x - 1 && direction == "right" {
            exchange(emptyItem1)
            return true
        }
        
        if self.coordinate.y == emptyItem1.coordinate.y && self.coordinate.x == emptyItem1.coordinate.x + 1 && direction == "left" {
            exchange(emptyItem1)
            return true
        }
        
        if self.coordinate.y == emptyItem2.coordinate.y && self.coordinate.x == emptyItem2.coordinate.x - 1 && direction == "right" {
            exchange(emptyItem2)
            return true
        }
        
        if self.coordinate.y == emptyItem2.coordinate.y && self.coordinate.x == emptyItem2.coordinate.x + 1 && direction == "left" {
            exchange(emptyItem2)
            return true
        }
        
        if self.coordinate.x == emptyItem1.coordinate.x && self.coordinate.y == emptyItem1.coordinate.y - 1 && direction == "down" {
            exchange(emptyItem1)
            return true
        }
        
        if self.coordinate.x == emptyItem1.coordinate.x && self.coordinate.y == emptyItem1.coordinate.y + 1 && direction == "up" {
            exchange(emptyItem1)
            return true
        }
        
        if self.coordinate.x == emptyItem2.coordinate.x && self.coordinate.y == emptyItem2.coordinate.y - 1 && direction == "down" {
            exchange(emptyItem2)
            return true
        }
        
        if self.coordinate.x == emptyItem2.coordinate.x && self.coordinate.y == emptyItem2.coordinate.y + 1 && direction == "up" {
            exchange(emptyItem2)
            return true
        }
        
        return false
    }
}
