import UIKit

/// SearchViewController - allows the user to search a movie and display the searched results into a TableView
class SearchViewController: UIViewController, UISearchBarDelegate {
    //MARK: - Properties
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    private var searchResults = [Movie]()
    
    //Test Data
    private var data = [String]()
    
    //MARK: - ViewController Lifecycle Events
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
   
        createSearchBar()
        createTableView()
        
        //API Network call
        let networkManager = NetworkManager()
        networkManager.fetchMovies(query: "frozen", type: .search)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.searchResults = networkManager.fetchedMovies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        addLayoutConstraints()
    }
    
        
        
    
    //MARK: - User Interface
    private func createSearchBar(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search a movie"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    private func createTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
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
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let movie = self.searchResults[indexPath.row]
        cell.posterImageView.image = movie.posterImage
        cell.movieTitleLabel.text = movie.title + " (\(movie.year))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
    
    
}