//
//  HomeProvider.swift
//  MovieIosDicoding
//
//  Created by Putra on 19/11/21.
//

import Foundation
import UIKit


class HomeProvider: HomeProviderProtocol {
    
    
    func createHome() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "home") as! HomeViewController
        
        let homeProtocol = Injection.init().provideHome()
        let homeViewModel = HomeViewModel(homeProtocol: homeProtocol)
        
        homeViewController.homeViewModel = homeViewModel
        
        return homeViewController
    }
    
    
}
