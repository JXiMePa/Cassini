//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Tarasenco Jurik on 02.04.2018.
//  Copyright © 2018 Tarasenco Jurik. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {




    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier] {
//                var destination = segue.destination //1
//                if let navcon = destination as? UINavigationController { //2 //go to extension
//                    destination = navcon.visibleViewController ?? navcon
                
                if let imageVC = segue.destination.contents as? ImageViewController {
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
}
extension UIViewController {
    var contents : UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
