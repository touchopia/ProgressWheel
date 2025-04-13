//
//  ViewController.swift
//  CircleApp
//
//  Created by Phil Wright on 4/13/25.
//

import UIKit

class ViewController: UIViewController {
    
    let shape = CAShapeLayer()
    let speedType:SpeedType = .fast
    
    // Define the speed of the circle animation
    enum SpeedType: Int {
        case fast = 1
        case slow = 2
        case drag = 3
    }
    
    func addCircle() {
        let circlePath = UIBezierPath(arcCenter: view.center,
                                     radius: 150,
                                     startAngle: -(.pi / 2),
                                    endAngle: .pi * 2,
                                    clockwise: true)

        let trackPath = CAShapeLayer()
        trackPath.path = circlePath.cgPath
        trackPath.lineWidth = 15
        trackPath.fillColor = UIColor.clear.cgColor
        trackPath.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackPath)
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 15
        shape.strokeColor = UIColor.blue.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        view.layer.addSublayer(shape)
    }
    
    func addLabel(withGoal goal: String) {
        let label = UILabel()
        label.textAlignment = .center
        label.text = goal
        label.font = .systemFont(ofSize: 40, weight: .bold)
        view.addSubview(label)
        label.sizeToFit()
        label.center = view.center
    }
    
    func addButton(withTitle title:String) {
        let button = UIButton(frame: CGRect(x: 20,
                                            y: view.frame.size.height - 170,
                                            width: view.frame.size.width - 40,
                                            height: 50))
        view.addSubview(button)

        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        addCircle()
        addLabel(withGoal: "Coding Goal")
        addButton(withTitle: "Start Animation")
    }

    @objc func didTapButton() {
        
        // Animate
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.toValue = 1
        
        var duration: CGFloat = 1.0
        
        switch speedType {
            case .fast: duration = 0
    
            case .slow: duration = 5.0
            case .drag: duration = 10.0
        }
        
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shape.add(animation, forKey:"animation")
    }
}
