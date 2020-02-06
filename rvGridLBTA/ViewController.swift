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
    
    // When the app creates the cells, it also puts them in a dictionary with their corresponding key (column/row)
    // The pan gesture will calculate which column/row it is touching so it can retrieve the corresponding cell from the dictionary
    private var cells = [String: UIView]() // instantiate cells dictionary with key of "column/row" and value of cellView
    
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
                
                let key = "\(i)|\(j)" // set key to cell's row and column
                cells[key] = cellView // set cellView at key in cells dictionnary
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
        let location = gesture.location(in: view) // get finger location as CGPoint coordinates
        
        // INEFFICIENT LOOP
        // This loop goes through all the cells, one after the other until it finds the cell being touched (at location).
        // Touching bottom row cells means the app goes through the loop a high number of times (depending on how many cells there are in the grid).
//        for subview in view.subviews { // access all subviews of view
//            if subview.frame.contains(location) { // check if cell is being touched
//                subview.backgroundColor = .black
//            }
//        }
        
        let cellSize = view.frame.width / numCellsPerRow
        let numberOfRows = view.frame.height / cellSize
        let i = Int(location.x / cellSize) // calculate which column is being touched
        let j = Int(location.y / numberOfRows) // calaculate which row is being touched
        let cellView = cells["\(i)|\(j)"] // get the corresponding cellView from the dictionary
        cellView?.backgroundColor = .red
    }
    
}

