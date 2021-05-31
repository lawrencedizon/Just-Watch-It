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
        let homeNavBarVC = UINavigationController()
        let searchNavBarVC = UINavigationController()
        let watchListNavBarVC = UINavigationController()
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let watchListVC = WatchListViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        watchListVC.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(systemName: "film.fill"), tag: 2)
        
        homeNavBarVC.viewControllers = [homeVC]
        searchNavBarVC.viewControllers = [searchVC]
        watchListNavBarVC.viewControllers = [watchListVC]
        
        let tabBarList = [homeNavBarVC, searchNavBarVC, watchListNavBarVC]
        viewControllers = tabBarList
    }
}
