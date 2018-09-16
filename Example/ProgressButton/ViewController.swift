//
//  ViewController.swift
//  ProgressButton
//
//  Created by aatanac on 09/16/2018.
//  Copyright (c) 2018 aatanac. All rights reserved.
//

import UIKit
import ProgressButton

final class ViewController: UIViewController {

    private var timer: Timer?
    @IBOutlet weak var button: ProgressButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonPressed(_ sender: ProgressButton) {
        sender.isUserInteractionEnabled = false
        self.timer = Timer(fireAt: Date(), interval: 0.5, target: self, selector: #selector(self.handleProgress), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer!, forMode: .defaultRunLoopMode)
    }
    
    @objc private func handleProgress() {
        if self.button.progress > 1.0 {
            self.timer?.invalidate()
            self.timer = nil
            self.button.reset(to: 0)
            self.button.isUserInteractionEnabled = true
        } else {
            self.button.progress += CGFloat(arc4random_uniform(20)) / 100
        }

    }
    
}

