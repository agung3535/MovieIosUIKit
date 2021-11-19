//
//  ProfileProvider.swift
//  MovieIosDicoding
//
//  Created by Putra on 19/11/21.
//

import Foundation
import UIKit


class ProfileProvider: ProfileProviderProtocol {
    func createProfile() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        let profileProtocol = Injection.init().provideProfile()
        let profileViewModel = ProfileViewModel(profileProtocol: profileProtocol)
        profileViewController.profileViewModel = profileViewModel
        return profileViewController
    }
    
    
}
