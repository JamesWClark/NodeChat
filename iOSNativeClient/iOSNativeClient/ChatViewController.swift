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
        addConnectionHandlers()
        addMessageHandlers()
        socket!.connect()
    }

    // MARK: Socket Handlers
    
    // register socket handlers
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
    }
    
    func addConnectionHandlers() {
        socket?.on("connect") { data, ack in
            // TODO: connection status light
            print("### -- SOCKET CONNECTED                -- ###")
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
        msg = chatLabel.text
        socket?.emit("message", [msg])
    }
    
    
}

