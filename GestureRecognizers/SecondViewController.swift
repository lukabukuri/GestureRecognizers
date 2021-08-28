//
//  SecondViewController.swift
//  Luka_Bukuri_Homework28
//
//  Created by Luka Bukuri on 09.06.21.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    static var isPressed = true

    @IBOutlet weak var coordinates: UILabel!
    var gestureName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureImageView()
    }
    
    func configureImageView()
    {
        imageView.isUserInteractionEnabled = true
        
        switch gestureName {
        case "Pan":
           let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            imageView.addGestureRecognizer(panGesture)
        case "LongPress":
            
            
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            longPressGesture.minimumPressDuration = 1
            
            let longTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLongTap(_:)))
            
            imageView.addGestureRecognizer(longPressGesture)
            imageView.addGestureRecognizer(longTapGesture)
            
         
        case "Swipe":
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            imageView.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
            imageView.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
            imageView.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
            imageView.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
            imageView.addGestureRecognizer(swipeGesture)
            
        case "Pinch":
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            
            imageView.addGestureRecognizer(pinchGesture)
            
        default:
            break
        }
    }

}
    
extension SecondViewController {

    @objc func handlePan(_ gesture: UIPanGestureRecognizer)
    {
        let translation = gesture.translation(in: self.view)
        switch gesture.state {
        case .changed:
            self.imageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            self.coordinates.text = "x: \(translation.x) y: \(translation.y)"
        case .ended:
            UIView.animate(withDuration: 0.3) {
                self.imageView.transform = .identity
            }
        default:
            break
        }
    }
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer)
    {
        
        switch gesture.state
        {
        case .began:
            SecondViewController.isPressed = false
        
        case .ended:
                SecondViewController.isPressed = true
           
        case .cancelled:
            print("canceled")
        default:
            break
        }
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer)
    {

        var frame = imageView.frame
        switch gesture.direction {
            case .up:
                frame.origin.y -= 50
            case .down:
                frame.origin.y += 50
            case .left:
                frame.origin.x -= 50
            case .right:
                frame.origin.x += 50
            default:
                break
            }
        UIView.animate(withDuration: 0.25) {
                self.imageView.frame = frame
        }
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer)
    {
        switch gesture.state {
        case .changed:
            imageView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
        case .ended:
            let intersection = imageView.superview!.bounds.intersection(imageView.frame)
            if !intersection.equalTo(imageView.frame) {
                UIView.animate(withDuration: 0.3) {
                     self.imageView.transform = .identity
            }
                }
        default:
            break
        }
    }
    
    @objc func handleLongTap(_ gesture: UITapGestureRecognizer)
    {
        if SecondViewController.isPressed
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            SecondViewController.isPressed = true
        }
    }
    
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }
}
