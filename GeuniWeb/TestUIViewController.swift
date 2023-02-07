//
//  TestUIViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import UIKit

class TestUIViewController: UIViewController {

    var originBrightnessValue = 0.5
    var brightnessValue = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.originBrightnessValue = UIScreen.main.brightness
        self.brightnessValue = self.originBrightnessValue
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapBrightUp(_ sender: Any) {
        if brightnessValue > 1.0 {
            return
        }
        brightnessValue += 0.1
        UIScreen.main.brightness = self.brightnessValue
    }
    
    @IBAction func didTapBridgeDown(_ sender: Any) {
        if brightnessValue < 0.1 {
            return
        }
        brightnessValue -= 0.1
        UIScreen.main.brightness = self.brightnessValue
    }
    @IBAction func didTapBrightInit(_ sender: Any) {
        UIScreen.main.brightness = self.originBrightnessValue
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
