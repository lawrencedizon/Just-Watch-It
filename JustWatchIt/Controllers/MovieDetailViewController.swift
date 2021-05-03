import UIKit
import CoreData

///MovieDetailViewController - displays all the movie's information to the user
class MovieDetailViewController: UIViewController {
    static let identifier = "MovieDetailViewController"
    var movie: Movie?
    lazy var detailView: MovieDetailView = {
        let detailView = MovieDetailView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        detailView.addToWatchListButton.addTarget(self, action: #selector(addRecord(_:)), for: .touchUpInside)
        detailView.posterImage.image = movie?.posterImage
        detailView.backDropImage.image = movie?.backDropImage
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
        guard let posterImage = movie?.posterImage?.jpeg else { return  }
        record.setValue(movie?.title, forKey: "title")
        record.setValue(2000, forKey: "year")
        record.setValue(posterImage, forKey: "posterImage")
        
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
