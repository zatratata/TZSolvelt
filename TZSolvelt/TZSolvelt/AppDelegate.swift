//
//  AppDelegate.swift
//  TZSolvelt
//
//  Created by Default User on 5/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = configureMainScreen()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func configureMainScreen() -> ClassRoomViewController {
        let interactor = ClassRoomInteractor()
        let presenter = ClassRoomViewPresenter(interactor: interactor)
        let viewController = ClassRoomViewController(presenter: presenter)
        presenter.view = viewController
        interactor.output = presenter
        return viewController
    }
}

