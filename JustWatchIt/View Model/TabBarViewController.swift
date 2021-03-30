import UIKit

/// TabBar View Controller used to display commonly accessed ViewControllers
class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)

        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let discoverVC = DiscoverViewController()
        discoverVC.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "star.fill"), tag: 1)
        
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        
        let watchListVC = WatchListViewController()
        watchListVC.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(systemName: "film.fill"), tag: 3)
        
        
        let tabBarList = [homeVC,discoverVC, searchVC,watchListVC]
        viewControllers = tabBarList
        
        
        print("TabBar VC loaded")
    }

}
