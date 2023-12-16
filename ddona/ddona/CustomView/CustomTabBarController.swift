//
//  CustomTabBarController.swift
//  ddona
//
//  Created by 유준용 on 2023/12/13.
//
import UIKit

class CustomTabBarViewController: UITabBarController {

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK: - Configure UI
    
    private func configureTabBar(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().backgroundColor = UIColor(hexCode: "#191919")
        tabBar.isTranslucent = false
        tabBar.layer.shadowColor = UIColor.systemGray.cgColor
        tabBar.layer.shadowOpacity = 1.0
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        tabBar.layer.shadowRadius = 1
        setViewControllers([createMakeCharacterViewController(), createChatViewController()], animated: true)
        selectedIndex = 0
    }
    
    // MARK: - Set TabBar's ViewControllers
    
    private func createMakeCharacterViewController() -> UINavigationController {
        let nav = UINavigationController(rootViewController: MakeCharacterViewController())
        let item = configureTabBarItemTitle(imageName: "create")
        nav.tabBarItem = item
        return nav
    }

    private func createChatViewController() -> UINavigationController {
        // 나중에 처음인지 아닌지 확인해야함
        let nav = UINavigationController(rootViewController: CompleteViewController())
        let item = configureTabBarItemTitle(imageName: "my")
        nav.tabBarItem = item
        return nav
    }
    
    private func configureTabBarItemTitle(imageName: String ) -> UITabBarItem{
        let item = UITabBarItem(title: "", image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
                                selectedImage: UIImage(named: imageName + "_select")?.withRenderingMode(.alwaysOriginal))
        return item
    }
    
    //MARK: - TabBarViewController Methods
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
