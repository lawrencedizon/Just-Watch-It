import UIKit

class HomeViewController: UIViewController {
    
    // Movie data
    var popularMoviesArray    = [Movie]()
    var inTheatersMoviesArray = [Movie]()
    var comingSoonMoviesArray = [Movie]()
    var topRatedMoviesArray   = [Movie]()
    
    private weak var collectionViewA: UICollectionView!
    private weak var collectionViewB: UICollectionView!
    private weak var collectionViewC: UICollectionView!
    private weak var collectionViewD: UICollectionView!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.showsVerticalScrollIndicator = false
           return scrollView
       }()
    
    private let title1: UILabel = {
        let title1 = UILabel()
        title1.translatesAutoresizingMaskIntoConstraints = false
        title1.text = "Popular"
        title1.font = UIFont.boldSystemFont(ofSize: 23)
        title1.textColor = .white
        return title1
    }()
    
    private let title2: UILabel = {
        let title2 = UILabel()
        title2.translatesAutoresizingMaskIntoConstraints = false
        title2.text = "In Theaters"
        title2.font = UIFont.boldSystemFont(ofSize: 23)
        title2.textColor = .white
        return title2
    }()
    
    private let title3: UILabel = {
        let title3 = UILabel()
        title3.translatesAutoresizingMaskIntoConstraints = false
        title3.text = "Coming Soon"
        title3.font = UIFont.boldSystemFont(ofSize: 23)
        title3.textColor = .white
        return title3
    }()
    
    private let title4: UILabel = {
        let title4 = UILabel()
        title4.translatesAutoresizingMaskIntoConstraints = false
        title4.text = "Top Rated"
        title4.font = UIFont.boldSystemFont(ofSize: 23)
        title4.textColor = .white
        return title4
    }()

    
    var data: [Int] = Array(0..<100)
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIXME: - API Testing
        let networkManager1 = NetworkManager()
        networkManager1.fetchFilms(type: .popular)
        let networkManager2 = NetworkManager()
        networkManager2.fetchFilms(type: .nowPlaying)

        let networkManager3 = NetworkManager()
        networkManager3.fetchFilms(type: .comingSoon)

        let networkManager4 = NetworkManager()

        networkManager4.fetchFilms(type: .topRated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
            self.popularMoviesArray = networkManager1.movies
            print(self.popularMoviesArray.count)
            self.inTheatersMoviesArray = networkManager2.movies
            self.comingSoonMoviesArray = networkManager3.movies
            self.topRatedMoviesArray = networkManager4.movies
        }
        
       
        //
        
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(title1)
        scrollView.addSubview(title2)
        scrollView.addSubview(title3)
        scrollView.addSubview(title4)
        
        addConstraints()
       
        self.collectionViewA.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellA")
        self.collectionViewB.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellB")
        self.collectionViewC.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellC")
        self.collectionViewD.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellD")

        self.collectionViewA.alwaysBounceVertical = true
        self.collectionViewA.backgroundColor = .black

        self.collectionViewB.alwaysBounceVertical = true
        self.collectionViewB.backgroundColor = .black

        self.collectionViewC.alwaysBounceVertical = true
        self.collectionViewC.backgroundColor = .black

        self.collectionViewD.alwaysBounceVertical = true
        self.collectionViewD.backgroundColor = .black

        self.collectionViewA.delegate = self
        self.collectionViewB.delegate = self
        self.collectionViewC.delegate = self
        self.collectionViewD.delegate = self

        self.collectionViewA.dataSource = self
        self.collectionViewB.dataSource = self
        self.collectionViewC.dataSource = self
        self.collectionViewD.dataSource = self 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height + 400)
    }
    
    override func loadView() {
        super.loadView()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionViewA = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionViewA.translatesAutoresizingMaskIntoConstraints = false
        collectionViewA.collectionViewLayout = layout

        let collectionViewB = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionViewB.translatesAutoresizingMaskIntoConstraints = false
        collectionViewB.collectionViewLayout = layout

        let collectionViewC = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionViewC.translatesAutoresizingMaskIntoConstraints = false
        collectionViewC.collectionViewLayout = layout

        let collectionViewD = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionViewD.translatesAutoresizingMaskIntoConstraints = false
        collectionViewD.collectionViewLayout = layout

        self.collectionViewA = collectionViewA
        self.collectionViewB = collectionViewB
        self.collectionViewC = collectionViewC
        self.collectionViewD = collectionViewD
        collectionViewA.showsHorizontalScrollIndicator = false
        collectionViewB.showsHorizontalScrollIndicator = false
        collectionViewC.showsHorizontalScrollIndicator = false
        collectionViewD.showsHorizontalScrollIndicator = false

        scrollView.addSubview(collectionViewA)
        scrollView.addSubview(collectionViewB)
        scrollView.addSubview(collectionViewC)
        scrollView.addSubview(collectionViewD)
    }
    
    private func addConstraints(){
        var constraints = [NSLayoutConstraint]()
        //Add constraints
        
        //ScrollView
        constraints.append(scrollView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(scrollView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(scrollView.rightAnchor.constraint(equalTo: view.rightAnchor))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        //Title1
        constraints.append(title1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20))
        constraints.append(title1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(title1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
       
        //Title2
        constraints.append(title2.topAnchor.constraint(equalTo: collectionViewA.bottomAnchor, constant: 30))
        constraints.append(title2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(title2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        //Title3
        constraints.append(title3.topAnchor.constraint(equalTo: collectionViewB.bottomAnchor, constant: 30))
        constraints.append(title3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(title3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        //Title4
        constraints.append(title4.topAnchor.constraint(equalTo: collectionViewC.bottomAnchor, constant: 30))
        constraints.append(title4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(title4.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        
        // CollectionViewA
        constraints.append(collectionViewA.topAnchor.constraint(equalTo: title1.topAnchor, constant: 30))
        constraints.append(collectionViewA.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewA.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        constraints.append(collectionViewA.heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))

        // CollectionViewB
        constraints.append(collectionViewB.topAnchor.constraint(equalTo: title2.bottomAnchor, constant: 10))
        constraints.append(collectionViewB.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewB.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewB.heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))
        
        // CollectionViewC
        constraints.append(collectionViewC.topAnchor.constraint(equalTo: title3.topAnchor, constant: 30))
        constraints.append(collectionViewC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewC.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewC.heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))
        constraints.append(collectionViewC.heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))

        // CollectionViewD
        constraints.append(collectionViewD.topAnchor.constraint(equalTo: title4.topAnchor, constant: 30))
        constraints.append(collectionViewD.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewD.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewD.heightAnchor.constraint(equalToConstant: view.frame.width/2 + 50))
        
      
   
        //Activate (applying)
        NSLayoutConstraint.activate(constraints)
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        20
    }
   
    // == is a heavy operation use tags instead
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewA {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellA", for: indexPath) as! MovieCollectionViewCell
            let data = self.data[indexPath.item]
            cellA.backgroundColor = .red
            cellA.layer.cornerRadius = 20
            cellA.layer.masksToBounds = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                cellA.imageView?.image = self.popularMoviesArray[indexPath.row].thumbnail
            }
            return cellA
            
        }else if collectionView == collectionViewB {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellB", for: indexPath) as! MovieCollectionViewCell
            let data = self.data[indexPath.item]
            cellB.backgroundColor = .blue
            
            
            cellB.layer.cornerRadius = 20
            cellB.layer.masksToBounds = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                cellB.imageView.image = self.inTheatersMoviesArray[indexPath.row].thumbnail
            }
            return cellB
        } else if collectionView == collectionViewC {
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellC", for: indexPath) as! MovieCollectionViewCell
            let data = self.data[indexPath.item]
            cellC.backgroundColor = .green
            
            
            cellC.layer.cornerRadius = 20
            cellC.layer.masksToBounds = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                cellC.imageView.image = self.comingSoonMoviesArray[indexPath.row].thumbnail
            }
            return cellC
        }

        else {
            let cellD = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellD", for: indexPath) as! MovieCollectionViewCell
            let data = self.data[indexPath.item]
            cellD.backgroundColor = .orange
            
            
            cellD.layer.cornerRadius = 20
            cellD.layer.masksToBounds = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                cellD.imageView.image = self.topRatedMoviesArray[indexPath.row].thumbnail
            }
            return cellD
            
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
