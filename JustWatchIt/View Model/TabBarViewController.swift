import UIKit

/// TabBar View Controller used to display commonly accessed ViewControllers
class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let discoverVC = DiscoverViewController()
        discoverVC.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "star"), tag: 1)
        
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        
        let watchListVC = WatchListViewController()
        watchListVC.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(systemName: "film"), tag: 3)
        
        
        let tabBarList = [homeVC,discoverVC, searchVC,watchListVC]
        viewControllers = tabBarList
        
        print("TabBar VC loaded")
    }

}
