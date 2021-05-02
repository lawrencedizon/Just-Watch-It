import UIKit

///MovieDetailViewController - displays all the movie's information to the user
class MovieDetailViewController: UIViewController {
    static let identifier = "MovieDetailViewController"
    
    lazy var detailView: MovieDetailView = {
        let detailView = MovieDetailView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        return detailView
    }()

    override func viewDidLoad(){
        super.viewDidLoad()
        view.addSubview(detailView)
    }
}
