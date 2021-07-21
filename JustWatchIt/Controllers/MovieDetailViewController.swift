import UIKit
import CoreData

///MovieDetailViewController - displays all the movie's information to the user
class MovieDetailViewController: UIViewController {
    static let identifier = "MovieDetailViewController"
    var movie: Movie?
    
    lazy var detailView: MovieDetailView = {
        let detailView = MovieDetailView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        if let title = movie?.title {
            if !checkIfRecordExists(title: title, type: "WatchListMovie") {
                detailView.addToWatchListButton.setTitle("+ add to Watchlist", for: .normal)
            detailView.addToWatchListButton.addTarget(self, action: #selector(addRecord(_:)), for: .touchUpInside)
            }
        }
        
        if let posterImage = movie?.posterImage {
            detailView.posterImage.url("\(GETMethods.LOWRESIMAGE)\(posterImage)")
        }
        
        if let backDropImage = movie?.backDropImage {
            detailView.backDropImage.url("\(GETMethods.HIGHRESIMAGE)\(backDropImage)")
        }
        
        detailView.titleLabel.text = movie?.title
        if let genres = movie?.genres {
            if genres.count > 3 {
                detailView.genreLabel.text = GenreConverter.getGenreString(genreArray: Array(genres[1...3]))
            }else{
                detailView.genreLabel.text = GenreConverter.getGenreString(genreArray: genres)
            }
        }
        
        detailView.yearLabel.text = movie?.year
        detailView.movieDescription.text = movie?.storyLine
        return detailView
    }()
        
    // Core Data adding data
    @objc func addRecord(_ sender: UIButton){
        if let title = movie?.title {
            if checkIfRecordExists(title: title, type: "WatchListMovie") {
                detailView.addToWatchListButton.isHidden = true
                return
            }else{
                detailView.addToWatchListButton.isHidden = false
            }
        }
        detailView.addToWatchListButton.setTitleColor(UIColor.green, for: .normal)
        detailView.addToWatchListButton.setTitle("added to Watchlist!", for: .normal)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "WatchListMovie", in: managedContext)!
        
        let record = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        record.setValue(movie?.title, forKey: "title")
        if let year = movie?.year {
            record.setValue(Int(DateConverterHelper.getYear(date: year)), forKey: "year")
        }
        record.setValue(movie?.posterImage, forKey: "posterImage")
        record.setValue(movie?.backDropImage, forKey: "backdropImage")
        record.setValue(movie?.storyLine, forKey: "storyLine")
        if let genres = movie?.genres {
            record.setValue(GenreConverter.getGenreString(genreArray: genres), forKey: "genres")
        }
       
        // 4
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        view.addSubview(detailView)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        UIView.setAnimationsEnabled(false)
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
}
