//
//  ViewController.swift
//  rvGridLBTA
//
//  Created by Herve Desrosiers on 2020-02-05.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let borderWidth: CGFloat = 1
    private let numCellsPerRow: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setCellView()
    }
    
    private func setCellView() {
        let cellSize = view.frame.width / numCellsPerRow
        let numberOfRows = view.frame.height / cellSize
        for j in 0...Int(numberOfRows) { // column for loop (rows per screen)
            for i in 0...Int(numCellsPerRow) { // row for loop (columns per row)
                let cellView: UIView = {
                    let cv = UIView()
                    cv.translatesAutoresizingMaskIntoConstraints = false
                    cv.backgroundColor = randomColor()
                    cv.layer.borderColor = UIColor.white.cgColor
                    cv.layer.borderWidth = borderWidth
                    cv.frame = CGRect(x: CGFloat(i) * cellSize, y: CGFloat(j) * cellSize, width: cellSize, height: cellSize)
                    return cv
                }()
                view.addSubview(cellView)
            }
        }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        print(location)
    }
    
}

