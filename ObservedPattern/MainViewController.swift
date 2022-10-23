//
//  MainViewController.swift
//  ObservedPattern
//
//  Created by Kelly Chui on 2022/10/23.
//

import Foundation
import UIKit

extension Notification.Name {
    static let colorChange = Notification.Name("change")
}

class MainViewController: UIViewController {
    
    let redButton: UIButton = {
        let button = UIButton()
        button.setTitle("Red", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(tapRed), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Blue", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapBlue), for: .touchUpInside)
        return button
    }()
    
    @objc func tapRed() {
        NotificationCenter.default.post(name: Notification.Name.colorChange, object: nil, userInfo: [NotificationKey.color: UIColor.systemRed])
    }
    
    @objc func tapBlue() {
        NotificationCenter.default.post(name: Notification.Name.colorChange, object: nil, userInfo: [NotificationKey.color: UIColor.systemBlue])
    }
    
    func buttonLayout() {
        view.addSubview(redButton)
        view.addSubview(blueButton)
        
        redButton.translatesAutoresizingMaskIntoConstraints = false
        blueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            redButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            redButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blueButton.topAnchor.constraint(equalTo: redButton.bottomAnchor),
            blueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout()
    }
}
