import UIKit
import CoreData

///WatchListsVC displays the movies that is on their Watchlist. It also shows them a list of movies that they finished watching.
class WatchListViewController: UIViewController {
    
    //The WatchList and SeenList uses one TableView to display data
    private var sharedTableView: UITableView!
    private var watchListMovieArray = [WatchListMovie]()
    private var seenListMovieArray = [SeenListMovie]()
    
    private let segmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["Watchlist","Seen"])
        segmentedControl.frame = CGRect(x: 110, y: 70, width: 170, height: 35)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .black
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
        segmentedControl.addTarget(self, action: #selector(onPressegmentControlButton(_:)), for: UIControl.Event.valueChanged )
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
        view.addSubview(segmentedControl)
        createTableView()
        
        //Core Data testing
        //deleteRecords(of: "SeenListMovie")
        //deleteRecords(of: "WatchListMovie")
        fetchCoreDataMovies(of: "WatchListMovie")
        sharedTableView.reloadData()
        layoutConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCoreDataMovies(of: "WatchListMovie")
        sharedTableView.reloadData()
    }
    
    private func createTableView(){
        sharedTableView = UITableView(frame: CGRect(x: 0, y: 120, width: view.bounds.width, height: 0.75 * view.bounds.height))
        sharedTableView.delegate = self
        sharedTableView.dataSource = self
        sharedTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        sharedTableView.backgroundColor = .black
        sharedTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sharedTableView)
    }
    
    //SegmentedControlButton action
    @objc func onPressegmentControlButton(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
            print("Fetching WatchList")
            fetchCoreDataMovies(of: "WatchListMovie")
          case 1:
            print("Fetching SeenList")
            fetchCoreDataMovies(of: "SeenListMovie")
          default:
            print("NONE AT ALL")
       }
        sharedTableView.reloadData()
    }
    
    //MARK:- Core Data
    func deleteRecords(of entityName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
           print ("There was an error")
        }
    }
    
    // Add record to CoreData graph
    func addRecord(title: String, year: Int, poster: String, backdrop: String, storyLine: String, genres: String, entityName: String ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        let record = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        record.setValue(title, forKey: "title")
        record.setValue(year, forKey: "year")
        record.setValue(poster, forKey: "posterImage")
        record.setValue(storyLine, forKey: "storyLine")
        record.setValue(backdrop, forKey: "backdropImage")
        record.setValue(genres, forKey: "genres")
        
        // 4
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //FIXME: - Remove specific record
    //I believe the fetch isn't properly retrieving.
    //We should give the WatchListMovie and SeenlistMovie UUIDs
    func removeRecord(movieTitle: String,from entityName: String){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            deleteFetch.predicate = NSPredicate(format: "title == %d", movieTitle)
        
            do {
                try context.execute(deleteFetch)
                try context.save()
            } catch {
               print ("There was an error")
            }
            
    }
    
    func fetchCoreDataMovies(of entityName: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            if entityName == "WatchListMovie" {
                let movieArray = try managedContext.fetch(fetchRequest) as! [WatchListMovie]
                watchListMovieArray = movieArray.reversed()
            }else {
                let movieArray = try managedContext.fetch(fetchRequest) as! [SeenListMovie]
                seenListMovieArray = movieArray.reversed()
            }
        }catch let error as NSError {
            print("Could not fetch movie. \(error), \(error.userInfo)")
        }
    }
    
    
    private func layoutConstraints(){
        var constraints = [NSLayoutConstraint]()
        //segmentedControl
        constraints.append(segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25))
        constraints.append(segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        //sharedTableView
        constraints.append(sharedTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 25))
        constraints.append(sharedTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(sharedTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20))
        constraints.append(sharedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - TableView Delegate Functions
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       segmentedControl.selectedSegmentIndex == 0 ? watchListMovieArray.count : seenListMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let movie = watchListMovieArray[indexPath.row]
            if let title = movie.title, let posterImage = movie.posterImage {
                cell.movieTitleLabel.text = "\(title) (\(movie.year))"
                cell.posterImageView.url("\(GETMethods.LOWRESIMAGE)\(posterImage)")
            }
        }else if segmentedControl.selectedSegmentIndex == 1{
            let movie = seenListMovieArray[indexPath.row]
            if let title = movie.title, let posterImage = movie.posterImage {
                cell.movieTitleLabel.text = "\(title) (\(DateConverterHelper.getYear(date: String(movie.year))))"
                cell.posterImageView.url("\(GETMethods.LOWRESIMAGE)\(posterImage)")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailVC = MovieDetailViewController()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            //Pass the movie data to movieDetailVC
           
            let watchListMovie = self.watchListMovieArray[indexPath.row]
            if let title = watchListMovie.title,
               let poster = watchListMovie.posterImage,
               let backdrop = watchListMovie.backdropImage,
               let storyLine = watchListMovie.storyLine,
               let genres = watchListMovie.genres{
                movieDetailVC.movie = Movie(title: title, posterImage: poster, backDropImage: backdrop, year: String(watchListMovie.year), storyLine: storyLine, genres: GenreConverter.getGenreArray(genreString: genres))
            }
           
        }else if segmentedControl.selectedSegmentIndex == 1{
            let seenListMovie = self.seenListMovieArray[indexPath.row]
            if let title = seenListMovie.title,
               let poster = seenListMovie.posterImage,
               let backdrop = seenListMovie.backdropImage,
               let storyLine = seenListMovie.storyLine{
                movieDetailVC.movie = Movie(title: title, posterImage: poster, backDropImage: backdrop, year: String(seenListMovie.year), storyLine: storyLine, genres: [])
            }
        }
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    func tableView(_ tableView: UITableView,
                    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Seen", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let movie = self.watchListMovieArray[indexPath.row]
            if let title = movie.title, let poster = movie.posterImage, let backdrop = movie.backdropImage, let storyLine = movie.storyLine, let genres = movie.genres{
                self.addRecord(title: title, year: Int(movie.year), poster: poster, backdrop: backdrop, storyLine: storyLine, genres: genres, entityName: "SeenListMovie")
                print("Added movie to seenlist")
                success(true)
                
            }
            
           
            })
        modifyAction.image = UIImage(named: "hammer")
        modifyAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
}

extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
}





