//
//  ScaleView.swift
//  CustomScaleView
//
//  Created by Csongor G. Korosi on 12/04/2020.
//  Copyright © 2020 BrotherSoft. All rights reserved.
//

import UIKit

protocol ScaleViewDelegate {
    func scaleView(_ : ScaleView, didChangeToValue value: Int)
}

//MARK: - Lifecycle

class ScaleView: UIView {
    var scrollView: UIScrollView!
    var labelsView: UIView!
    var linesView: UIView!
    
    var delegate: ScaleViewDelegate?
    
    var value: Int = 0
    var numberOfUnits = 30
    var unitWidth = 70
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
}

//MARK: - UI

extension ScaleView {
    func setupUI() {
        addScrollView()
        addLabelsView()
        addLinesView()
        addIndicatorView()
    }
    
    func addScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height))
        scrollView.contentSize = CGSize(width: CGFloat(numberOfUnits * unitWidth), height: self.frame.size.height)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: self.frame.size.width/2, bottom: 0, right: self.frame.size.width/2)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        addSubview(scrollView)
    }
    
    func addLabelsView() {
        labelsView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.scrollView.contentSize.width, height: self.frame.size.height/3))
        scrollView.addSubview(labelsView)
    }
    
    func addLinesView() {
        linesView = UIView(frame: CGRect(x: 0.0, y: self.frame.size.height/3, width: self.scrollView.contentSize.width, height: self.frame.size.height/3*2))
        scrollView.addSubview(linesView)
        
        addHorizontalLines()
        addBigVerticalLines()
    }
    
    func addHorizontalLines() {
        let lineViewHeight = 2.0
        let lineView = UIView(frame: CGRect(x: CGFloat(0.0), y: linesView.frame.size.height/2 - CGFloat(lineViewHeight/2), width: linesView.frame.size.width, height: CGFloat(lineViewHeight)))
        lineView.backgroundColor = UIColor(red: 242/255.0, green: 178/255.0, blue: 0, alpha: 0.75)
        linesView.addSubview(lineView)
    }
    
    func addBigVerticalLines() {
        for index in 0...Int(numberOfUnits) {
            let bigLineViewX = CGFloat(index*unitWidth)
            let lineView = UIView(frame: CGRect(x: bigLineViewX, y: 0.0, width: 2.0, height: linesView.frame.size.height))
            lineView.backgroundColor = UIColor(red: 242/255.0, green: 178/255.0, blue: 0, alpha: 1.0)
            linesView.addSubview(lineView)
            
            addLabel(from: bigLineViewX, index: index)
            
            if index != numberOfUnits {
                addSmallLines(from: bigLineViewX)
            }
        }
    }
    
    func addLabel(from xPosition: CGFloat, index: Int) {
        let labelWidth = CGFloat(20.0)
        let label = UILabel(frame: CGRect(x: xPosition - labelWidth/2 + 1.0, y: 0.0, width: labelWidth, height: labelsView.frame.size.height/4*3))
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.text = "\(index * 10)"
        label.font = UIFont(name: "Avenir-Medium", size: 10)
        labelsView.addSubview(label)
    }
    
    func addSmallLines(from xPosition: CGFloat) {
        for index in 1...4 {
            let smallLineViewX =  xPosition + CGFloat(index * unitWidth/5)
            let lineView = UIView(frame: CGRect(x: smallLineViewX, y: linesView.frame.size.height/8, width: 1.0, height: linesView.frame.size.height/4 * 3))
            lineView.backgroundColor = UIColor(red: 242/255.0, green: 178/255.0, blue: 0, alpha: 0.75)
            linesView.addSubview(lineView)
        }
    }
    
    func addIndicatorView() {
        let indicatorView = UIImageView(frame: CGRect(x: frame.size.width / 2 - frame.size.height / 12, y: frame.size.height + 5.0, width: frame.size.height / 6, height: frame.size.height / 6))
        indicatorView.image = UIImage(named: "triangle_icon")
        addSubview(indicatorView)
    }
    
    func updateScaleValue() {
        let value =  Int((scrollView.contentOffset.x + scrollView.frame.size.width/2) * CGFloat(numberOfUnits) * 10 / scrollView.contentSize.width)
        if value >= 0 && value <= numberOfUnits * 10 {
            self.value = Int(value)
            self.delegate?.scaleView(self, didChangeToValue: Int(value))
        }
    }
}

//MARK: - UIScrollViewDelegate

extension ScaleView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateScaleValue()
    }
}

