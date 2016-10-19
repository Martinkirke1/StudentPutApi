//
//  StudentController.swift
//  StudentPutApi
//
//  Created by Martin Kirke on 10/19/16.
//  Copyright © 2016 Ghost. All rights reserved.
//

import Foundation

class StudentController {
    
    /*
     work:
     -endpoints
     -function for getting student
     -function for adding a student
     */
    
    // properties
    
    static var baseURL = URL(string: "https://names-e4301.firebaseio.com/students")
    
    
    // appending to the baseURl
    static let getEndPoint = baseURL?.appendPathExtension("json")
    
    // methods
    
    static func send(studenWithName name: String, completion: (( _ success: Bool) -> Void)? = nil) {
        
        // create Student instance
        let student = Student(name: name)
        
        // add student name to url
        guard let url = baseURL?.appendingPathComponent(name).appendingPathExtension("json") else { return }
        
        // call th networkcontroller to send the data to firebase
        NetworkController.preformRequest(for: url, httpMethod: .Put, body: student.jsonData) { (data, error) in
            
            var success = false
            
            defer {
                
                if let completion = completion {
                    completion(success)
                }
            }
            
            
            guard let responseDataString = String(data: data!, encoding: .utf8) else { return }
            
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
                return
            } else if responseDataString.contains("error") {
                
                NSLog("Error: \(responseDataString)")
            } else {
                
                print("Successfully saved data to the endpoint.  \nResponse: \(responseDataString)")
                success = true
            }
            // see whether or not it worked
        }
        
    }
    
}
