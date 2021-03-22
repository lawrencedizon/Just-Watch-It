//
//  HomeViewController.swift
//  JustWatchIt
//
//  Created by Lawrence Dizon on 3/17/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HomeVC loaded")
        view.backgroundColor = .white
        
        /* Brute-force approach, use AutoLayout later */
        let title1 = UILabel(frame: CGRect(x: 10, y: 60, width: 300, height: 100))
        let title2 = UILabel(frame: CGRect(x: 10, y: 260, width: 300, height: 100))
        let title3 = UILabel(frame: CGRect(x: 10, y: 460, width: 300, height: 100))
        let title4 = UILabel(frame: CGRect(x: 10, y: 660, width: 300, height: 100))
        
        title1.text = "Popular"
        title1.font = title1.font.withSize(20)
        title2.text = "Now in Theaters"
        title2.font = title2.font.withSize(20)
        title3.text = "Upcoming Movies"
        title3.font = title3.font.withSize(20)
        title4.text = "Top Rated Movies"
        title4.font = title4.font.withSize(20)
        view.addSubview(title1)
        view.addSubview(title2)
        view.addSubview(title3)
        view.addSubview(title4)
        
    }
    
    

    

}
