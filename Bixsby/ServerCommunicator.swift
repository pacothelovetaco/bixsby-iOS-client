//
//  ServerCommunicator.swift
//  Bixsby
//
//  Created by Justin on 3/4/15.
//  Copyright (c) 2015 Justin. All rights reserved.
//

import Foundation

class ServerCommunicator {
   
    var client: TCPClient
    var sessionId: String?
    
    init(){
        client = TCPClient(addr: "BIXSBY_IP", port: 2001 )
        connectToServer()
    }
    
    
    func respondTo(input: String) -> String {
        var json = "{session_id: \(sessionId!), input: \(input)}"
        
        println("[App] sending: \(json)")
        
        //let (success, errmsg) = client.send(str: "GET / HTTP/1.0\n\n")
        
        let (success, errmsg) = client.send(data: (json as NSString).dataUsingEncoding(NSUTF8StringEncoding)!)
        if success {
            let response = readData()
            return response!
        }
        return ""
    }
    
    func connectToServer() {
        var (success, errmsg) = client.connect(timeout: 10)
        if success {
            println("[APP] Connected to \(client)")
            readData()
        } else {
            println(errmsg)
        }
    }
    
    func readData() -> String? {
        let data = client.read(1024*10)
        
        if let serverResponse = data {
            if let str = String(bytes: serverResponse, encoding: NSUTF8StringEncoding) {
                println("[Bixsby] response: \(str)")
                
                let jsonData = (str as NSString).dataUsingEncoding(NSUTF8StringEncoding)
                let response = parseResponse(jsonData!)
                
                sessionId = response.session_id
                return response.response
            }
        }
        return nil
    }

    func parseResponse(jsonData: NSData) -> (session_id: String, response: String) {
        var error: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
        
        return (jsonDict["session_id"]! as String, jsonDict["response"]! as String)
        
    }
    
}
