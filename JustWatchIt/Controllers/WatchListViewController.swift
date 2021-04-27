import UIKit

///WatchListsVC displays the movies that is on their Watchlist. It also shows them a list of movies that they finished watching.
class WatchListViewController: UIViewController {
    private var watchListTableView: UITableView!
    
    let segmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["Unwatched","Watched"])
        segmentedControl.frame = CGRect(x: 90, y: 70, width: 200, height: 40)
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
    
    //Create a segmented control at the very top
    //Create a tableView
    // Height of 250?
    // Left- MovieImage
    // Right - Title and Description of movie below (TextView field)
}

//MARK: - TableView Delegate Functions
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.textLabel?.text = "Hi"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
}
