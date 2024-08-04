//
//  LZTabBarController.swift
//  react-native-swift
//
//  Created by Saiki on 2024/7/31.
//

import UIKit

class LZTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        initTabBar()
    }
    
    func initTabBar(){
        let home = HomeViewController()
        home.tabBarItem.title = "Arena"
        home.tabBarItem = UITabBarItem.init(title: "Arena", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon"))
        let score = ScoreViewController()
        score.tabBarItem = UITabBarItem.init(title: "Sports", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon"))
        let live = LiveViewController()
        live.tabBarItem = UITabBarItem.init(title: "Live", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon"))
        let community = CommunityViewController()
        community.tabBarItem = UITabBarItem.init(title: "Community", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon"))
        let mine = MineViewController()
        mine.tabBarItem = UITabBarItem.init(title: "Forecast", image: UIImage(named: "community_tabbar_icon", in: Bundle.main, with: nil), selectedImage: UIImage(named: "community_tabbar_icon"))
        
        self.viewControllers = [home, score, live, community, mine]
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor(r: 8, g: 8, b: 8, a: 0.8)

        
        let appearnce = UITabBarAppearance()
        appearnce.configureWithOpaqueBackground()
        appearnce.backgroundColor = UIColor(r: 8, g: 8, b: 8, a: 0.8)
        tabBar.standardAppearance = appearnce
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearnce
        } else {
            // Fallback on earlier versions
        }
        // 设置 tabBar & tabBarItem
        setTabBarItemAttributes(bgColor: UIColor(r: 8, g: 8, b: 8, a: 0.8))
        
        NotificationCenter.default.addObserver(self, selector: #selector(recvNotification(_:)), name: NSNotification.Name(rawValue: "tabJump"), object: nil)
    }
    
    
    /// 这种方式比较灵活
        func setTabBarItemAttributes(fontName: String = "Courier",
                                     fontSize: CGFloat = 14,
                                     normalColor: UIColor = UIColor(r: 163, g: 163, b: 163, a: 1),
                                     selectedColor: UIColor = UIColor.white,
                                     bgColor: UIColor = UIColor.white) {
            // tabBarItem 文字大小
            var attributes: [NSAttributedString.Key: Any] = [:]
            
            // tabBarItem 文字默认颜色
            attributes[.foregroundColor] = normalColor
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
            
            // tabBarItem 文字选中颜色
            attributes[.foregroundColor] = selectedColor
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
            
            // tabBar 文字、图片 统一选中高亮色
            tabBar.tintColor = selectedColor
            
            // tabBar 背景色
            tabBar.barTintColor = bgColor
        }
    
    
    func configTabBarItem(controller: UIViewController) {
        let tabBarApperance = controller.tabBarItem.standardAppearance?.copy() ?? UITabBarAppearance()
        tabBarApperance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        tabBarApperance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.red]
        tabBarApperance.stackedLayoutAppearance.normal.iconColor = .orange
        tabBarApperance.stackedLayoutAppearance.selected.iconColor = .blue
        tabBarApperance.backgroundColor = .purple
        tabBarApperance.backgroundEffect = nil
        
        tabBarItem.standardAppearance = tabBarApperance
    }
    
    @objc func recvNotification(_ notification:Notification) {
        let index = notification.object as! Int
        self.selectedIndex = index
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: 关于屏幕旋转
extension LZTabBarController {
    
    open override var shouldAutorotate: Bool {
        return self.selectedViewController?.shouldAutorotate ?? false
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.selectedViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.selectedViewController?.preferredInterfaceOrientationForPresentation ?? UIInterfaceOrientation.portrait
    }
}
