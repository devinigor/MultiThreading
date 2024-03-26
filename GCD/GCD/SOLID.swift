//
//  SOLID.swift
//  GCD
//
//  Created by Игорь Девин on 26.03.2024.
//

import UIKit

class SOLID: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

protocol Light {
    func turnOn()
    func turnOff()
}

class LightBulb: Light {
    
    func turnOn() {
        // включает свет
    //lamp.on()
    }

    func turnOff() {
        // включает свет
   // lamp.off()
    }
}

class Switch {
    let bulb: Light

    init(bulb: Light) {
        self.bulb = bulb
    }

    func toggle() {
        bulb.turnOn()
    }
}
