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
        
        /* Brute-force approach, use AutoLayout later*/
        let title1 = UITextView(frame: CGRect(x: 0, y: 50, width: 300, height: 100))
        let title2 = UITextView(frame: CGRect(x: 0, y: 100, width: 300, height: 100))
        let title3 = UITextView(frame: CGRect(x: 0, y: 150, width: 300, height: 100))
        let title4 = UITextView(frame: CGRect(x: 0, y: 200, width: 300, height: 100))
        
        title1.text = "Popular"
        title2.text = "Now in Theaters"
        title3.text = "Upcoming Movies"
        title4.text = "Top Rated Movies"
        view.addSubview(title1)
        view.addSubview(title2)
        view.addSubview(title3)
        view.addSubview(title4)
        
    }
    
    

    

}
