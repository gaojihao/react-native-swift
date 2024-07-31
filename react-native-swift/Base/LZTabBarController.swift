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
//        tabBar.items = [UITabBarItem.init(title: "Arena", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon")),
//                        UITabBarItem.init(title: "Arena", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon")),
//                        UITabBarItem.init(title: "Arena", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon")),
//                        UITabBarItem.init(title: "Arena", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon")),
//                        UITabBarItem.init(title: "Arena", image: UIImage(named: "community_tabbar_icon"), selectedImage: UIImage(named: "community_tabbar_icon"))]
        // 设置 tabBar & tabBarItem
//        setTabBarItemAttributes(bgColor: UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1))
    }
    
    /// 这种方式比较灵活
        func setTabBarItemAttributes(fontName: String = "Courier",
                                     fontSize: CGFloat = 14,
                                     normalColor: UIColor = .gray,
                                     selectedColor: UIColor = .red,
                                     bgColor: UIColor = .white) {
            // tabBarItem 文字大小
            var attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: fontName, size: fontSize)!]
            
            // tabBarItem 文字默认颜色
            attributes[.foregroundColor] = normalColor
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
            
            // tabBarItem 文字选中颜色
            attributes[.foregroundColor] = selectedColor
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
            
            // tabBar 文字、图片 统一选中高亮色
//            tabBar.tintColor = selectedColor
            
            // tabBar 背景色
            tabBar.barTintColor = bgColor
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
