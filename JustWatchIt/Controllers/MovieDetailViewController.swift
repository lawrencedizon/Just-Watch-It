import UIKit
import CoreData

///MovieDetailViewController - displays all the movie's information to the user
class MovieDetailViewController: UIViewController {
    static let identifier = "MovieDetailViewController"
    var movie: Movie?
    lazy var detailView: MovieDetailView = {
        let detailView = MovieDetailView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        detailView.addToWatchListButton.addTarget(self, action: #selector(addRecord(_:)), for: .touchUpInside)
        if let posterImage = movie?.posterImage {
            detailView.posterImage.url("\(GETMethods.LOWRESIMAGE)\(posterImage)")
        }
        
        if let backDropImage = movie?.backDropImage {
            detailView.backDropImage.url("\(GETMethods.HIGHRESIMAGE)\(backDropImage)")
        }
        
        detailView.titleLabel.text = movie?.title
        detailView.yearLabel.text = movie?.year
        detailView.movieDescription.text = movie?.storyLine
        return detailView
    }()
    
    // Core Data adding data
    @objc func addRecord(_ sender: UIButton){
        detailView.addToWatchListButton.setTitleColor(UIColor.orange, for: .normal)
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
        // 4
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("Added to watchList")
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        view.addSubview(detailView)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        UIView.setAnimationsEnabled(false)
    }
}
