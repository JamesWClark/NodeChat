//
//  UsernameViewController.swift
//  iOSNativeClient
//
//  Created by J.W. Clark on 10/19/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class UsernameViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnSubmitUsername: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Action Outlets
    
    @IBAction func btnSubmitUsernamePressed(_ sender: UIButton) {
        
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if btnSubmitUsername === sender as? UIButton {
            let chatVC = segue.destination as! ChatViewController
            chatVC.username = txtUsername.text
        }
    }
}
