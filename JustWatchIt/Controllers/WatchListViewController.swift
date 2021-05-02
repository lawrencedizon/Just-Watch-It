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
        segmentedControl.backgroundColor = .black
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentControl(_:)), for: UIControl.Event.valueChanged )
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
        if let kongImage = UIImage(named: "kongPoster.jpg")?.jpeg{
            addRecord(title: "Kong", year: 2017, poster: kongImage, entityName: "WatchListMovie")
        }
//        if let movieImage = UIImage(named: "movie.jpg")?.jpeg{
//            addRecord(title: "1917", year: 1917, poster: movieImage, entityName: "WatchListMovie")
//        }
        if let movie2Image = UIImage(named: "movie2.jpg")?.jpeg{
            addRecord(title: "Archer", year: 2020, poster: movie2Image, entityName: "SeenListMovie")
        }
        fetchCoreDataMovies(of: "WatchListMovie")
        sharedTableView.reloadData()
    }
    
    private func createTableView(){
        sharedTableView = UITableView(frame: CGRect(x: 0, y: 120, width: view.bounds.width, height: 0.75 * view.bounds.height))
        sharedTableView.delegate = self
        sharedTableView.dataSource = self
        sharedTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        sharedTableView.backgroundColor = .black
        view.addSubview(sharedTableView)
    }
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
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
    
    // Core Data adding data
    func addRecord(title: String, year: Int, poster: Data, entityName: String){
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
        
        // 4
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
                watchListMovieArray = movieArray
            }else {
                let movieArray = try managedContext.fetch(fetchRequest) as! [SeenListMovie]
                seenListMovieArray = movieArray
            }
        }catch let error as NSError {
            print("Could not fetch movie. \(error), \(error.userInfo)")
        }
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
                cell.posterImageView.image = UIImage(data: posterImage)
            }
        }else if segmentedControl.selectedSegmentIndex == 1{
            let movie = seenListMovieArray[indexPath.row]
            if let title = movie.title, let posterImage = movie.posterImage {
                cell.movieTitleLabel.text = "\(title) (\(movie.year))"
                cell.posterImageView.image = UIImage(data: posterImage)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
}

extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
}




