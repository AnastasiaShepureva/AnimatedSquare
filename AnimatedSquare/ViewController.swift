//
//  ViewController.swift
//  AnimatedSquare
//
//  Created by Анастасия Шепурева on 31.03.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private var square: UIView!
    private var gradientLayer: CAGradientLayer!
    
    // properties for resizing the square
    private var width: NSLayoutConstraint!
    private var height: NSLayoutConstraint!
    private var constant: CGFloat = 150
    private lazy var newConstant: CGFloat = {
        let value = sqrtf(powf(Float(constant), 2) * 2)
        return CGFloat(value)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSquare()
        animateSquare()
        setupGradientBackground()
    }
    
// MARK: - Configure UI
    fileprivate func setupGradientBackground() {
      
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.yellow.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
    
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    fileprivate func setupSquare() {
        square = UIView()
        
        square.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(square)
        square.backgroundColor = .systemBlue
        width = square.widthAnchor.constraint(equalToConstant: constant)
        height = square.heightAnchor.constraint(equalToConstant: constant)
        
        NSLayoutConstraint.activate([
            square.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            square.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            width,
            height
        ])

    }
// MARK: - Animations:
    
    fileprivate func animateSquare() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 3.0, delay: 0.5, options: .curveEaseInOut) {[self] in

                // animating constraints
                changeConstraints()
                
                // animating using Affine Transform
//                transformSquare()
      
                square.backgroundColor = .systemPink
                square.layer.cornerRadius = 7
                view.layoutSubviews()
            }
            self.animateBackground()
        }
        
    }
    
    fileprivate func animateBackground() {
        let newColors = [UIColor.yellow.cgColor, UIColor.systemPink.cgColor]
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = newColors
        animation.duration = 3.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        gradientLayer.add(animation, forKey: "colors")
    
    }
    
    fileprivate func transformSquare() {
        let scale = newConstant / constant
        square.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    fileprivate func changeConstraints() {
 
        height.constant = newConstant
        width.constant = newConstant

    }

}

