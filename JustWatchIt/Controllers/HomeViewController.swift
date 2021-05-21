import UIKit

class HomeViewController: UIViewController {
    //MARK: - Properties
    
    ///scrollView - the Main view's subview that contains the titleLabels and collectionViews
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        //Configure scrollView properties
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
       }()
    
    ///movieArray - array that contains an array of Movie data that is retrieved from the NetworkManager
    private lazy var arrayOfArrayMovies: [[Movie]] = {
        var arrayOfArrayMovies = [[Movie]]()
        
            //Initialize each empty array of Movie and add it to arrayOfArraymovies array
            for index in 0..<Constants.numberOfCollectionViewMovieLists{
                let movieArray = [Movie]()
                arrayOfArrayMovies.append(movieArray)
            }
        
        return arrayOfArrayMovies
    }()
    
    ///titleLabelArray - array that contains the title labels
    private lazy var titleLabelArray: [UILabel] = {
        var titleLabelArray = [UILabel]()
        
        //Configure UILabel properties
        for index in 0..<Constants.numberOfCollectionViewMovieLists{
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.font = UIFont(name: "Helvetica", size: 24)
            title.textColor = .white
            
            //Add each titleLabel to the titleLabelArray
            titleLabelArray.append(title)
        }
        //Declare each label's title
        titleLabelArray[0].text = "Popular"
        titleLabelArray[1].text = "Now Playing"
        titleLabelArray[2].text = "Upcoming"
        titleLabelArray[3].text = "Top Rated"
        
        return titleLabelArray
    }()
    
    ///collectionViewArray -  array that contains collectionViews that display movie posters
    private lazy var collectionViewArray: [UICollectionView] = {
        var collectionViewArray = [UICollectionView]()
        
        for index in 0..<Constants.numberOfCollectionViewMovieLists {
            
            //Setup collectionView layout
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            //Create collectionView
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout:layout)
            
            //collectionView properties
            collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell\(index)")
            collectionView.tag = index
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.bounces = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .black
            
            //Add collectionView to collectionViewArray
            collectionViewArray.append(collectionView)
        }
        return collectionViewArray
    }()
    
    //MARK: - ViewController LifeCycle
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
    
        // Add ScrollView to main view
        view.addSubview(scrollView)
        
        //Add titles to ScrollView
        for title in titleLabelArray{
            scrollView.addSubview(title)
        }
        
        //Add collectionViews to scrollView
        for collectionView in collectionViewArray {
            collectionView.delegate = self
            collectionView.dataSource = self
            scrollView.addSubview(collectionView)
        }
        addLayoutConstraints()
        fetchAllMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height + 380)
    }
    
    //MARK: - API Management
    ///fetchAllMovies() - creates an array of NetworkManagers to fetch movie data and copies the Movie data into arrayOfArrayMovies
    func fetchAllMovies(){
        var networkManagerArray = [NetworkManager]()
        
        //Create a NetworkManager for each fetch type
        for index in 0..<Constants.numberOfCollectionViewMovieLists{
            let networkManager = NetworkManager()
            switch(index){
                case 0:
                    networkManager.fetchMovies(type: .popular)
                case 1:
                    networkManager.fetchMovies(type: .nowPlaying)
                case 2:
                    networkManager.fetchMovies(type: .upcoming)
                case 3:
                    networkManager.fetchMovies(type: .topRated)
                default:
                    break
            }
            networkManagerArray.append(networkManager)
        }
 
        // Assign fetched API movie data to our arrayOfArrayMovies
        DispatchQueue.main.asyncAfter(deadline: .now() + 14) {
            for index in 0..<Constants.numberOfCollectionViewMovieLists{
                self.arrayOfArrayMovies[index] = networkManagerArray[index].fetchedMovies.shuffled()
            }
            
            DispatchQueue.main.async {
                for collectionView in self.collectionViewArray{
                    collectionView.reloadData()
                }
            }
        }
    }
   
    //MARK: - User Interface
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func addLayoutConstraints(){
        var constraints = [NSLayoutConstraint]()
        //ScrollView
        constraints.append(scrollView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(scrollView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(scrollView.rightAnchor.constraint(equalTo: view.rightAnchor))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        //Title0
        constraints.append(titleLabelArray[0].topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10))
        constraints.append(titleLabelArray[0].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(titleLabelArray[0].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
       
        //Title1
        constraints.append(titleLabelArray[1].topAnchor.constraint(equalTo: collectionViewArray[0].bottomAnchor, constant: 20))
        constraints.append(titleLabelArray[1].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(titleLabelArray[1].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        //Title2
        constraints.append(titleLabelArray[2].topAnchor.constraint(equalTo: collectionViewArray[1].bottomAnchor, constant: 20))
        constraints.append(titleLabelArray[2].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(titleLabelArray[2].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        //Title3
        constraints.append(titleLabelArray[3].topAnchor.constraint(equalTo: collectionViewArray[2].bottomAnchor, constant: 20))
        constraints.append(titleLabelArray[3].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(titleLabelArray[3].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        // CollectionView0
        constraints.append(collectionViewArray[0].topAnchor.constraint(equalTo: titleLabelArray[0].bottomAnchor, constant: 10))
        constraints.append(collectionViewArray[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewArray[0].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewArray[0].heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))

        // CollectionView1
        constraints.append(collectionViewArray[1].topAnchor.constraint(equalTo: titleLabelArray[1].bottomAnchor, constant: 10))
        constraints.append(collectionViewArray[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewArray[1].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewArray[1].heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))
        
        // CollectionView2
        constraints.append(collectionViewArray[2].topAnchor.constraint(equalTo: titleLabelArray[2].bottomAnchor, constant: 10))
        constraints.append(collectionViewArray[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewArray[2].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewArray[2].heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))
    
        // CollectionView3
        constraints.append(collectionViewArray[3].topAnchor.constraint(equalTo: titleLabelArray[3].bottomAnchor, constant: 10))
        constraints.append(collectionViewArray[3].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewArray[3].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewArray[3].heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))
        
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - UICollectionView Delegate Properties
extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        arrayOfArrayMovies[collectionView.tag].count
    }
   
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell\(collectionView.tag)", for: indexPath) as! MovieCollectionViewCell
        cell.backgroundColor = .red
            if let image = self.arrayOfArrayMovies[collectionView.tag][indexPath.row].posterImage{
                cell.posterImage.image = image
            }
            return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController()
        
        //Pass the movie data to movieDetailVC
        movieDetailVC.movie = self.arrayOfArrayMovies[collectionView.tag][indexPath.row]
        navigationController?.pushViewController(movieDetailVC, animated: true)
     }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5 + 10, height: collectionView.frame.width/2 + 50)
    }
}
