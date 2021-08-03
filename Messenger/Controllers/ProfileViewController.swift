//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Alexander Kim on 2021/07/18.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableVIew: UITableView!
    
    let data = ["Sign Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "",
                                            message: "",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Sign Out",
                                            style: .destructive,
                                            handler: { [weak self]_ in
                                                guard let strongSelf = self else {
                                                    return
                                                }
                                                
                                                // Facebook Sign Out
                                                FBSDKLoginKit.LoginManager().logOut()
                                                
                                                // Google Sign Out
                                                GIDSignIn.sharedInstance()?.signOut()
                                                
                                                
                                                do {
                                                    try FirebaseAuth.Auth.auth().signOut()
                                                    let vc = LoginViewController()
                                                    let nav = UINavigationController(rootViewController: vc)
                                                    nav.modalPresentationStyle = .fullScreen
                                                    strongSelf.present(nav, animated: true)
                                                    
                                                    
                                                }
                                                catch {
                                                    print("Failed to Sign Out")
                                                }
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        present(actionSheet, animated: true)
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
            
            
        }
        catch {
            print("Failed to Sign Out")
        }
        
    }
}
