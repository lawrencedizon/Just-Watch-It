import UIKit

/// TabBar View Controller used to display commonly accessed ViewControllers
class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "paperplane.fill"), tag: 0)
        
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let tabBarList = [homeVC,searchVC]
        viewControllers = tabBarList
        
        print("TabBar VC loaded")
    }

}
