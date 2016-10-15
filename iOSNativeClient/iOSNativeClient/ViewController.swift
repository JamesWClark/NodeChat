//
//  ViewController.swift
//  SwiftSocket
//
//  Created by J.W. Clark on 10/10/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // outlet references
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var chatText: UITextField!
    
    // temp message from server
    var msg: String?
    
    // the socket connected to server
    var socket: SocketIOClient? // optional
    
    // main method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket = SocketIOClient(socketURL: URL(string: "http://localhost")!)
        addHandlers()
        socket!.connect()
    }
    
    // register socket handlers
    func addHandlers() {
        
        // on every this first connection
        socket?.on("connected") { data, ack in
            // should show a green light or lightning bolt icon or something in UI
            print("\n##########\n --- SOCKET CONNECTED --- \n##########\n")
        }
        
        // server says hello
        socket?.on("welcome") {[weak self] data, ack in
            
            if let arr = data as? [[String: Any]] {
                if let txt = arr[0]["text"] as? String {
                    self?.chatLabel.text = txt
                    print("TXT---")
                    print(txt)
                    print("TXT---")
                }
            }
        }
    }
    
    // for actual devices
    func promptUserOnDevice() {
        
    }
    
}

