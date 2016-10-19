//
//  StudentTableViewController.swift
//  StudentPutApi
//
//  Created by Martin Kirke on 10/19/16.
//  Copyright © 2016 Ghost. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    
    //properties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var students = [Student]() {
        
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchStudents()
    }
    
    private func fetchStudents() {
        StudentController.fetchStudents { (students) in
            self.students = students
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        
        let student = students[indexPath.row]
        
        cell.textLabel?.text = student.name
        
        
        return cell
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        guard let name = nameTextField.text , name.characters.count > 0 else { return }
        
        StudentController.send(studenWithName: name) { (success) in
            
            guard success else { return }
            
            DispatchQueue.main.async {
                self.nameTextField.text = ""
                self.nameTextField.resignFirstResponder()
                
                self.fetchStudents()
            }
        }
        
        
    }
}
