import UIKit

/// SearchViewController - search a Movie and display the results into a TableView
class SearchViewController: UIViewController, UISearchBarDelegate {
    //MARK: - Properties
    var searchBar: UISearchBar!
    var tableView: UITableView!
    //Test Data
    var data = [String]()
    
    //MARK: - ViewController Lifecycle Events
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
   
        createSearchBar()
        createTableView()
        
        //Test Data
        for x in 0...100 {
            data.append("Some Data \(x)")
        }
        
        addLayoutConstraints()
    }
    //MARK: - User Interface
    func createSearchBar(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search a movie"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    func createTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func addLayoutConstraints(){
        var constraints = [NSLayoutConstraint]()
        //SearchBar
        constraints.append(searchBar.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50))
        constraints.append(searchBar.rightAnchor.constraint(equalTo: view.rightAnchor))
        constraints.append(searchBar.heightAnchor.constraint(equalToConstant: 70))
        
        //TableView
        constraints.append(tableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor))
        constraints.append(tableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
     
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - TableView Delegate Functions
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
