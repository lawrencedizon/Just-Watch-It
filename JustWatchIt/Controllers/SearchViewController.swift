import UIKit

/// SearchViewController - allows the user to search a movie and display the searched results into a TableView
class SearchViewController: UIViewController {
    //MARK: - Properties
    private var searchResults = [Movie]()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.searchBarStyle = UISearchBar.Style.minimal
            searchBar.placeholder = "Search a movie"
            searchBar.keyboardAppearance = UIKeyboardAppearance.dark
            searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.keyboardDismissMode = .onDrag
            tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .black
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return tableView
    }()
    
    //MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        setupUserInterface()
    }
    
    //MARK: - User Interface
    private func setupUserInterface(){
        view.backgroundColor = .black
        view.addSubview(searchBar)
        view.addSubview(tableView)
        layoutConstraints()
    }
    
    private func layoutConstraints(){
        var constraints = [NSLayoutConstraint]()
        //SearchBar
        constraints.append(searchBar.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50))
        constraints.append(searchBar.rightAnchor.constraint(equalTo: view.rightAnchor))
        constraints.append(searchBar.heightAnchor.constraint(equalToConstant: 70))
        
        //TableView
        constraints.append(tableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20))
        constraints.append(tableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
     
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - SearchBar Delegates
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        //API Network call
        let networkManager = NetworkManager()
        if let query = searchBar.text  {
                networkManager.fetchMovies(query: query.replacingOccurrences(of: " ", with: "-"), type: .search)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.searchResults = networkManager.fetchedMovies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }else{
            print("No text was inputted into the search bar")
        }
    }
}

//MARK: - TableView Delegates
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController()
        //Pass the movie data to movieDetailVC
        movieDetailVC.movie = self.searchResults[indexPath.row]
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        let movie = self.searchResults[indexPath.row]
        cell.selectionStyle = .none
        cell.posterImageView.url("\(GETMethods.LOWRESIMAGE)\(movie.posterImage)")
        cell.movieTitleLabel.text = movie.title + " (\(movie.year))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
    
    
}
