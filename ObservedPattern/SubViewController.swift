//
//  SubViewController.swift
//  ObservedPattern
//
//  Created by Kelly Chui on 2022/10/23.
//

import Foundation
import UIKit

enum NotificationKey {
    case color
}

class SubViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(changeBackGround(notification:)), name: Notification.Name.colorChange, object: nil)
    }
    
    @objc func changeBackGround(notification: Notification) {
        guard let object = notification.userInfo?[NotificationKey.color] as? UIColor else { return }
        self.view.backgroundColor = object
    }
}
