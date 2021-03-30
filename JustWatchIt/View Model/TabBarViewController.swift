import UIKit

/// TabBar View Controller -  display and navigate to commonly accessed ViewControllers
class TabBarViewController: UITabBarController {
    //MARK: - ViewController LifeCycle States
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTransparentTabBar()
        customizeTabBarColors()
        setupTabBarList()
    }
    
    //MARK: - TabBar Configuration
    func setTransparentTabBar(){
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
    }
    
    func customizeTabBarColors(){
        UITabBar.appearance().tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.darkGray
    }
    
    func setupTabBarList(){
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
    }
}
