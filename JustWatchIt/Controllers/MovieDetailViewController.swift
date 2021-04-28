import UIKit

///MovieDetailViewController - displays all the movie's information to the user
class MovieDetailViewController: UIViewController {
    static let identifier = "MovieDetailViewController"
    var detailView: MovieDetailView!
    // Add video trailer
    // UIElements needed: Poster image, movie title, genre, description
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("MovieDetailViewController loaded")
        detailView = MovieDetailView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        view.addSubview(detailView)
        
    }
    
   
   
    
    
    
    
    
}
