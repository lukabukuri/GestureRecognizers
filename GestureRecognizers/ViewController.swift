//
//  ViewController.swift
//  Luka_Bukuri_Homework28
//
//  Created by Luka Bukuri on 09.06.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var panGesture: UILabel!
    @IBOutlet weak var longPressGesture: UILabel!
    @IBOutlet weak var swipeGesture: UILabel!
    @IBOutlet weak var pinchGesture: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePanGesture()
        configureLongPressGesture()
        configureswipeGesture()
        configurePinchGesture()
        }
    
   func configurePanGesture()
    {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    gesture.name = "Pan"
    panGesture.isUserInteractionEnabled = true
    panGesture.addGestureRecognizer(gesture)
    }

    func configureLongPressGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        gesture.name = "LongPress"
        longPressGesture.isUserInteractionEnabled = true
        longPressGesture.addGestureRecognizer(gesture)
    }
    
    func configureswipeGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        gesture.name = "Swipe"
        swipeGesture.isUserInteractionEnabled = true
        swipeGesture.addGestureRecognizer(gesture)
    }
    
    func configurePinchGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        gesture.name = "Pinch"
        pinchGesture.isUserInteractionEnabled = true
        pinchGesture.addGestureRecognizer(gesture)
    }
}

extension ViewController
{
    @objc func handleTap(_ gesture: UITapGestureRecognizer)
    {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.gestureName = gesture.name
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

