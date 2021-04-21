import UIKit

class HomeViewController: UIViewController {
    //MARK: - Instance Variables
    private static let numberOfCategories = 4
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.showsVerticalScrollIndicator = false
           return scrollView
       }()

    var movieArray: [[Movie]] = {
    var moviesArray = [[Movie]]()
        for index in 0..<numberOfCategories{
            let movieArray = [Movie]()
            moviesArray.append(movieArray)
        }
        return moviesArray
    }()
    
    let titleArray: [UILabel] = {
        var titleArray = [UILabel]()
        for index in 0..<numberOfCategories{
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = ""
            title.font = UIFont.boldSystemFont(ofSize: 23)
            title.textColor = .white
            titleArray.append(title)
        }
        titleArray[0].text = "Popular"
        titleArray[1].text = "Now Playing"
        titleArray[2].text = "Upcoming"
        titleArray[3].text = "Top Rated"
        return titleArray
    }()
    
    let collectionViewArray: [UICollectionView] = {
        var collectionViewArray = [UICollectionView]()
        
        for index in 0..<numberOfCategories {
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
    
    //MARK: - ViewController LifeCycle States
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
    
        // Add ScrollView to main View
        view.addSubview(scrollView)
        
        //Add titles to ScrollView
        for title in titleArray{
            scrollView.addSubview(title)
        }
        
        //Add collectionViews to ScrollView
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
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height + 400)
    }
    
    //MARK: - API Management
    func fetchAllMovies(){
        var networkManagerArray = [NetworkManager]()
        
        for index in 0..<HomeViewController.numberOfCategories{
            let networkManager = NetworkManager()
            switch(index){
                case 0:
                    networkManager.fetchFilms(type: .popular)
                case 1:
                    networkManager.fetchFilms(type: .nowPlaying)
                case 2:
                    networkManager.fetchFilms(type: .upcoming)
                case 3:
                    networkManager.fetchFilms(type: .topRated)
                default:
                    break
            }
            networkManagerArray.append(networkManager)
        }
 
        // Assign fetched API movie data to our movieArray to display in our collectionView
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            for index in 0..<HomeViewController.numberOfCategories{
                self.movieArray[index] = networkManagerArray[index].movies.shuffled()
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
        constraints.append(titleArray[0].topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20))
        constraints.append(titleArray[0].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(titleArray[0].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
       
        //Title1
        constraints.append(titleArray[1].topAnchor.constraint(equalTo: collectionViewArray[0].bottomAnchor, constant: 30))
        constraints.append(titleArray[1].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(titleArray[1].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        //Title2
        constraints.append(titleArray[2].topAnchor.constraint(equalTo: collectionViewArray[1].bottomAnchor, constant: 30))
        constraints.append(titleArray[2].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(titleArray[2].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        //Title3
        constraints.append(titleArray[3].topAnchor.constraint(equalTo: collectionViewArray[2].bottomAnchor, constant: 30))
        constraints.append(titleArray[3].leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(titleArray[3].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        // CollectionView0
        constraints.append(collectionViewArray[0].topAnchor.constraint(equalTo: titleArray[0].topAnchor, constant: 30))
        constraints.append(collectionViewArray[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewArray[0].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewArray[0].heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))

        // CollectionView1
        constraints.append(collectionViewArray[1].topAnchor.constraint(equalTo: titleArray[1].bottomAnchor, constant: 10))
        constraints.append(collectionViewArray[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewArray[1].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewArray[1].heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))
        
        // CollectionView2
        constraints.append(collectionViewArray[2].topAnchor.constraint(equalTo: titleArray[2].topAnchor, constant: 35))
        constraints.append(collectionViewArray[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewArray[2].trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewArray[2].heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))
        constraints.append(collectionViewArray[2].heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))

        // CollectionView3
        constraints.append(collectionViewArray[3].topAnchor.constraint(equalTo: titleArray[3].topAnchor, constant: 35))
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
        movieArray[collectionView.tag].count
    }
   
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell\(collectionView.tag)", for: indexPath) as! MovieCollectionViewCell

            if let image = self.movieArray[collectionView.tag][indexPath.row].thumbnail{
                cell.imageView.image = image
            }
            return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        //TODO: - What happens when someone clicks on a cell
     }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5 + 10, height: collectionView.frame.width/2 + 50)
    }
}
