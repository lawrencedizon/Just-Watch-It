//
//  SearchViewController.swift
//  JustWatchIt
//
//  Created by Lawrence Dizon on 3/17/21.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y:50, width: view.bounds.size.width, height: 70)
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search a movie"
        view.addSubview(searchBar)
        print("Search VC loaded")
    }

}
