//
//  MainViewController.swift
//  OlaKAse
//
//  Created by Juan Felipe Alvarez Saldarriaga on 6/18/15.
//  Copyright © 2015 Juan Felipe Alvarez Saldarriaga. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKShareKit

class FriendsQueryTableViewController: PFQueryTableViewController {
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var loginBarButton: UIBarButtonItem!
    @IBOutlet weak var inviteBarButton: UIBarButtonItem!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        parseClassName = Friend.parseClassName()
        pullToRefreshEnabled = true
        paginationEnabled = true
        objectsPerPage = 25;
        loadingViewEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLoginBarButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        guard let currentUser = User.currentUser() else {
            return presentLogInVC()
        }
        
        let currentInstalation = PFInstallation()
        currentInstalation.setObject(currentUser, forKey: "user")
    }
    
    // MARK: - PFQueryTableViewController
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: parseClassName!)
        
        if pullToRefreshEnabled {
            query.cachePolicy = .NetworkOnly
        }
        
        if objects?.count == 0 {
            query.cachePolicy = .CacheElseNetwork
        }
        
        return query
    }
}

// MARK: - UI

extension FriendsQueryTableViewController {
    
    func presentLogInVC() {
        let loginVC = PFLogInViewController()
        loginVC.delegate = self
        loginVC.fields = [.Default, .Facebook]
        loginVC.facebookPermissions = ["public_profile", "email", "user_friends"]
        presentViewController(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func addBarButtonTapped(sender: UIBarButtonItem) {
    }
    
    func setupLoginBarButtonItem() {
        guard let _ = User.currentUser() else {
            loginBarButton.title = NSLocalizedString("Login", comment: "")
            
            return
        }
        
        loginBarButton.title = NSLocalizedString("Logout", comment: "")
    }
    
    @IBAction func loginBarButtonTapped(sender: UIBarButtonItem) {
        guard let _ = User.currentUser() else {
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("setupLoginBarButtonItem"), userInfo: nil, repeats: false)
            
            return presentLogInVC()
        }
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("setupLoginBarButtonItem"), userInfo: nil, repeats: false)
        
        User.logOutInBackground()
    }
    
    @IBAction func inviteBarButtonTapped(sender: UIBarButtonItem) {
        presentFacebookAppInviteDialog()
    }
}

// MARK: - FBSDKAppInviteDialogDelegate

extension FriendsQueryTableViewController: FBSDKAppInviteDialogDelegate {
    
    func presentFacebookAppInviteDialog() {
        let content = FBSDKAppInviteContent()
        content.appLinkURL = NSURL(string: "https://fb.me/1601337420135347")
        FBSDKAppInviteDialog.showWithContent(content, delegate: self)
    }
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        
    }
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
        
    }
}

// MARK: - PFLogInViewControllerDelegate

extension FriendsQueryTableViewController: PFLogInViewControllerDelegate {
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("setupLoginBarButtonItem"), userInfo: nil, repeats: false)
        
        logInController.dismissViewControllerAnimated(true, completion: nil)
    }
}

