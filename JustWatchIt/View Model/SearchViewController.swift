import UIKit

/// SearchViewController - search a Movie and display the results into a TableView
class SearchViewController: UIViewController, UISearchBarDelegate {
    //MARK: - Properties
    var searchBar: UISearchBar!
    
    //MARK: - ViewController Lifecycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createSearchBar()
    }
    
    //MARK: - SearchBar
    func createSearchBar(){
        searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y:50, width: view.bounds.size.width, height: 70)
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search a movie"
        view.addSubview(searchBar)
    }

}
