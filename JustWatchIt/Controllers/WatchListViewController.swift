import UIKit
import CoreData
import Lottie

///WatchListsVC displays the movies that is on their Watchlist. It also shows them a list of movies that they finished watching.
class WatchListViewController: UIViewController {
    //MARK: - Properties
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
    
    var animationView: AnimationView!
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
        view.addSubview(segmentedControl)
        createTableView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"trash" ),style: .plain, target: self, action: #selector(deleteWatchListRecords))

        //Core Data testing
        //deleteRecords(of: "SeenListMovie")
        //deleteRecords(of: "WatchListMovie")
        fetchCoreDataMovies(of: "WatchListMovie")
        sharedTableView.reloadData()
        
        setupAnimation()
        view.addSubview(animationView)
        layoutConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchCoreDataMovies(of: "WatchListMovie")
        sharedTableView.reloadData()
    }
    
    //MARK:- Methods
    private func createTableView(){
        sharedTableView = UITableView(frame: CGRect(x: 0, y: 120, width: view.bounds.width, height: 0.75 * view.bounds.height))
        sharedTableView.delegate = self
        sharedTableView.dataSource = self
        sharedTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        sharedTableView.backgroundColor = .black
        sharedTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        sharedTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sharedTableView)
    }
    
    //SegmentedControlButton action
    @objc func onPressegmentControlButton(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
            fetchCoreDataMovies(of: "WatchListMovie")
          case 1:
            stopAnimation()
            fetchCoreDataMovies(of: "SeenListMovie")
          default:
            return
       }
    }
    
    @objc func deleteWatchListRecords(){
        let alert = UIAlertController(title: "Warning", message: "Do you want to delete all records", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { [weak self] action in
            if self?.segmentedControl.selectedSegmentIndex == 0 {
                
                self?.deleteRecords(of: "WatchListMovie")
                self?.fetchCoreDataMovies(of: "WatchListMovie")
            }else if self?.segmentedControl.selectedSegmentIndex == 1{
                self?.deleteRecords(of: "SeenListMovie")
                self?.fetchCoreDataMovies(of: "SeenListMovie")
            }
        }))
        self.present(alert, animated: true, completion: nil)
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
        
        //animationView
        constraints.append(animationView.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(animationView.widthAnchor.constraint(equalToConstant: 100))
        
        constraints.append(animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100))
    
        
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Animation
    private func setupAnimation(){
        animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true
        animationView.animation = Animation.named("swipe-right")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
    }
    
    private func stopAnimation(){
        if let animView = animationView {
            animView.stop()
            animView.isHidden = true
        }
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
        sharedTableView.reloadData()
        stopAnimation()
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
    
    func removeRecord(movieTitle: String,from entityName: String){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            deleteFetch.predicate = NSPredicate(format: "title == %@", movieTitle)
            
            do {
                let objects = try context.fetch(deleteFetch)
                for object in objects {
                    context.delete(object as! NSManagedObject)
                }
                try context.save()
            } catch _ {
                print("Could not delete record")
            }
        
    }
    
    func checkIfRecordExists(title: String, type: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: type)
        fetchRequest.predicate = NSPredicate(format: "title LIKE %@" ,title)

        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
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
        sharedTableView.reloadData()
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
        cell.selectionStyle = .none
        
        if segmentedControl.selectedSegmentIndex == 0 {
            if(watchListMovieArray.count == 1){
                animationView.play()
                animationView.isHidden = false
            }else{
                stopAnimation()
            }
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
        if self.segmentedControl.selectedSegmentIndex == 0 {
        let modifyAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                let movie = self.watchListMovieArray[indexPath.row]
                guard let title = movie.title else { return }
                if(self.checkIfRecordExists(title: title, type: "SeenListMovie")){
                    return
                }else{
                    if let poster = movie.posterImage, let backdrop = movie.backdropImage, let storyLine = movie.storyLine, let genres = movie.genres{
                        self.addRecord(title: title, year: Int(movie.year), poster: poster, backdrop: backdrop, storyLine: storyLine, genres: genres, entityName: "SeenListMovie")
                        //delete record from watchList
                        self.removeRecord(movieTitle: title, from: "WatchListMovie")
                        
                        self.fetchCoreDataMovies(of: "WatchListMovie")
                        self.stopAnimation()
                        }
                }
            })

        modifyAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [modifyAction])
        }else{
            return UISwipeActionsConfiguration()
        }
    }
}

extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
}





