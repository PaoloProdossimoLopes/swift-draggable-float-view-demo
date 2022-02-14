//
//  ViewController.swift
//  DraggableView
//
//  Created by Paolo Prodossimo Lopes on 14/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var draggableView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(draggableView)
        draggableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(gestureHandle))
        draggableView.addGestureRecognizer(gesture)
    }
    
    @objc private func gestureHandle(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self.view)
        print(location)
        
        let dragView = gesture.view
        dragView?.center = location
        
        viewDraggedHandler(gesture, draggableView: dragView)
    }
    
    private func viewDraggedHandler(_ gesture: UIPanGestureRecognizer, draggableView: UIView?) {
        if gesture.state == .ended {
            if self.draggableView.frame.midX >= self.view.layer.frame.width / 2 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.draggableView.center.x = self.view.layer.frame.width - 40
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.draggableView.center.x = 40
                }, completion: nil)
            }
        }
    }
    
}

