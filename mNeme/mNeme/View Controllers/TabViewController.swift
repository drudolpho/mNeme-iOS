//
//  TabViewController.swift
//  mNeme
//
//  Created by Lambda_School_Loaner_204 on 2/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SOTabBar

class TabViewController: SOTabBarController {

    var userController: UserController?
    var demoDeckController: DemoDeckController?

    // Changes the settings for the tab bar
    override func loadView() {
        super.loadView()
        SOTabBarSetting.tabBarTintColor = UIColor.mNeme.orangeBlaze
        SOTabBarSetting.tabBarAnimationDurationTime = 0.25
        SOTabBarSetting.tabBarHeight = 60
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 60.0, height: 60.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabViewControllers()

    }

    private func setUpTabViewControllers() {
        // instantiating each navcontroller for view controller on tab bar
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")

        let deckCreateVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DeckCreateViewController")

        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")

        // Constants for tab bar icons/selected
        let homeImage = UIImage(systemName: "house")?.withTintColor(UIColor.mNeme.orangeBlaze, renderingMode: .alwaysOriginal)
        let homeImageSelected = UIImage(systemName: "house")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)

        let createImage = UIImage(systemName: "pencil")?.withTintColor(UIColor.mNeme.orangeBlaze, renderingMode: .alwaysOriginal)
        let createImageSelected = UIImage(systemName: "pencil")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)

        let profileImage = UIImage(systemName: "person")?.withTintColor(UIColor.mNeme.orangeBlaze, renderingMode: .alwaysOriginal)
        let profileImageSelected = UIImage(systemName: "person")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)

        // Setting up tab bar items for each view controller
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: homeImageSelected)
        deckCreateVC.tabBarItem = UITabBarItem(title: "Create Deck", image: createImage, selectedImage: createImageSelected)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, selectedImage: profileImageSelected)

        viewControllers = [homeVC, deckCreateVC, profileVC]
        tabBarViewControllerProperties()
    }

    // set up the view controllers on the tab bars with property data as needed
    private func tabBarViewControllerProperties() {
        guard let homeVC = self.viewControllers[0] as? HomeViewController,
            let _ = self.viewControllers[1] as? DeckCreateViewController,
            let profileVC = self.viewControllers[2] as? ProfileViewController else { return }

        profileVC.userController = self.userController
        homeVC.demoDeckController = self.demoDeckController
    }
}
