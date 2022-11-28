//
//  TabController.swift
//  Mural
//
//  Created by Emily Holmes on 11/28/22.
//


import UIKit

class TabController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gallery = GalleryController()
        let home = HomeController()
        
        self.setViewControllers([home, gallery], animated: true)
        
        tabBar.items?[0].image = UIImage(systemName: "paintbrush.pointed")
        tabBar.items?[1].image = UIImage(systemName: "rectangle.grid.3x2")
        // Do any additional setup after loading the view.
    }


}
