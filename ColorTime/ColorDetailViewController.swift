//
//  ColorDetailViewController.swift
//  ColorTime
//
//  Created by Nicholas Laughter on 6/27/16.
//  Copyright © 2016 Nicholas Laughter. All rights reserved.
//

import UIKit

class ColorDetailViewController: UIViewController {
    
    var color: Color?
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var backgroundSwitch: UISwitch!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var red: UILabel!
    @IBOutlet weak var green: UILabel!
    @IBOutlet weak var blue: UILabel!
    @IBOutlet weak var hex: UILabel!
    @IBOutlet weak var alpha: UILabel!
    @IBOutlet weak var background: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let color = color else { return }
        updateWithColor(color)
    }
    
    @IBAction func sliderMoved(sender: UISlider) {
        colorView.alpha = CGFloat(slider.value)
        alphaLabel.text = "\(slider.value)"
    }
    
    @IBAction func backgroundSwitchToggled(sender: UISwitch) {
        if sender.on {
            view.backgroundColor = .whiteColor()
        } else {
            view.backgroundColor = .blackColor()
        }
    }
    
    func updateWithColor(color: Color) {        
        updateColors(color.color)
        redLabel.text = "\(color.red)"
        greenLabel.text = "\(color.green)"
        blueLabel.text = "\(color.blue)"
        hexLabel.text = color.hex
        alphaLabel.text = "1.0"
        colorView.backgroundColor = color.color
    }
    
    func updateColors(color: UIColor) {
        UILabel.appearance().textColor = color.inverse()
        UISlider.appearance().tintColor = color.inverse()
        UISwitch.appearance().tintColor = color.inverse()
        UISwitch.appearance().onTintColor = UIColor.lightGrayColor()
        navigationController?.navigationBar.tintColor = color
    }
}
