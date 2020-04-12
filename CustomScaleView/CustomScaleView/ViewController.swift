//
//  ViewController.swift
//  CustomScaleView
//
//  Created by Csongor G. Korosi on 12/04/2020.
//  Copyright © 2020 Csongor G. Korosi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let scaleView = ScaleView(frame: CGRect(x: 0.0, y: view.frame.size.height / 3, width: view.frame.size.width, height: 40.0))
        scaleView.delegate = self
        view.addSubview(scaleView)
    }
}

extension ViewController: ScaleViewDelegate {
    func scaleView(_: ScaleView, didChangeToValue value: Int) {
        print("Scale View value: \(value)")
    }
}

