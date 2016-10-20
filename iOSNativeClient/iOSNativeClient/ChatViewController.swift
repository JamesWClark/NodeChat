//
//  ViewController.swift
//  SwiftSocket
//
//  Created by J.W. Clark on 10/10/16.
//  Copyright © 2016 J.W. Clark. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    // temp message from server
    var msg: String?
    
    // the socket connected to server
    var socket: SocketIOClient? // optional
    
    // the user's name :O
    var username: String?
    
    // outlet references
    @IBOutlet weak var chatLabel: UITextView!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var chatText: UITextField!
    
    // main method
    override func viewDidLoad() {
        super.viewDidLoad()

        socket = SocketIOClient(socketURL: URL(string: "http://localhost")!)
        addConnectionHandlers()
        addMessageHandlers()
        socket!.connect()
    }

    // MARK: Socket Handlers
    
    // register socket handlers for connected messaging
    func addMessageHandlers() {
        
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
        
        // another user sends a message
        socket?.on("message") { data, ack in
            if let arr = data as? [[String: Any]] {
                let message = arr[0]["message"] as! String
                let user = arr[0]["user"] as! String
                self.chatLabel.text = self.chatLabel.text! + "\n\(user) : \(message)"
                
                // auto scroll the text view with an animation
                let range = NSMakeRange(self.chatLabel.text.characters.count - 1, 0)
                self.chatLabel.scrollRangeToVisible(range)
                
                print("\n\(user): \(message)")
            }
        }
    }

    // register socket handlers for connection events
    func addConnectionHandlers() {
        socket?.on("connect") { data, ack in
            // TODO: connection status light
            print("### -- SOCKET CONNECTED                -- ###")
            
            self.socket?.emit("user", self.username!)
        }
        
        socket?.on("disconnect") { data, ack in
            // TODO: implement purposeful disconnect?
            print("### -- SOCKET DISCONNECTED             -- ###")
        }
        
        socket?.on("error") { data, ack in
            // TODO: display an error message
            print("### -- SOCKET ERROR                    -- ###")
        }
        
        socket?.on("reconnect") { data, ack in
            // TODO: something before a reconnect
            print("### -- SOCKET BEFORE RECONNECT ATTEMPT -- ###")
            
        }
        
        socket?.on("reconnectAttempt") { data, ack in
            // TODO: something while attempting reconnecting
            print("### -- SOCKET RECONNECT ATTEMPT        -- ###")
        }
    }
    
    // MARK: Action Outlets
    
    @IBAction func sendClicked(_ sender: UIButton) {
        let msg = chatText.text!
        socket?.emit("message", msg)
        chatText.text = ""
    }
}

