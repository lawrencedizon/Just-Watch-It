import UIKit

/// TabBarViewController -  display and navigate to commonly accessed ViewControllers
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
        let navBarVC = UINavigationController()
        let homeVC = HomeViewController()
        navBarVC.viewControllers = [homeVC]
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let watchListVC = WatchListViewController()
        watchListVC.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(systemName: "film.fill"), tag: 2)
        
        let tabBarList = [navBarVC, searchVC, watchListVC]
        viewControllers = tabBarList
    }
}
