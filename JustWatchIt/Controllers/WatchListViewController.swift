import UIKit
import CoreData

///WatchListsVC displays the movies that is on their Watchlist. It also shows them a list of movies that they finished watching.
class WatchListViewController: UIViewController {
    private var watchListTableView: UITableView!
    private var watchListMovieArray = [WatchListMovie]()
    private var seenMovieArray = [Movie]()
    
    private let segmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["Watchlist","Seen"])
        segmentedControl.frame = CGRect(x: 110, y: 70, width: 170, height: 35)
        segmentedControl.backgroundColor = .black
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
        view.addSubview(segmentedControl)
        createTableView()
        
        //Core Data testing
        //deleteAllRecords()
        
        addToWatchList(movieTitle: "Kong")
        addToWatchList(movieTitle: "Blues Clues")
        
        fetchCoreDataMovies()
        watchListTableView.reloadData()
    }
    
    private func createTableView(){
        //unWatchedTableView
        watchListTableView = UITableView(frame: CGRect(x: 0, y: 120, width: view.bounds.width, height: view.bounds.height))
        watchListTableView.delegate = self
        watchListTableView.dataSource = self
        watchListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        watchListTableView.backgroundColor = .black
        view.addSubview(watchListTableView)
    }
    
    //MARK:- Core Data
    func deleteAllRecords() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "WatchListMovie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
           print ("There was an error")
        }
    }
    
    // Core Data adding data
    func addToWatchList(movieTitle: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "WatchListMovie", in: managedContext)!
        
        let watchListMovie = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        watchListMovie.setValue(movieTitle, forKey: "movieTitle")
        
        // 4
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchCoreDataMovies(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WatchListMovie")
        
        do {
            watchListMovieArray = try managedContext.fetch(fetchRequest) as! [WatchListMovie]
        }catch let error as NSError {
            print("Could not fetch movie. \(error), \(error.userInfo)")
        }
    }
}

//MARK: - TableView Delegate Functions
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        segmentedControl.selectedSegmentIndex == 0 ? watchListMovieArray.count : seenMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.textLabel?.text = watchListMovieArray[indexPath.row].movieTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
}





