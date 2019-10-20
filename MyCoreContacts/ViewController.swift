//
//  ViewController.swift
//  MyCoreContacts
//
//  Created by Roberto Ocampo on 10/20/19.
//  Copyright © 2019 Roberto Ocampo. All rights reserved.
//

import UIKit
//0) Add import for CoreData
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var snapchat: UITextField!
    
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBAction func btnEdit(_ sender: UIButton) {
        //**Begin Copy**
        
        //0a Edit contact
        name.isEnabled = true
        snapchat.isEnabled = true
        birthdate.isEnabled = true
        phone.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        name.becomeFirstResponder()
        
        //**End Copy**
    }
    
    
    @IBAction func btnSave(_ sender: AnyObject) {
        //**Begin Copy**
        //1 Add Save Logic
        
        
        if (contactdb != nil)
        {
            
            contactdb.setValue(name.text, forKey: "name")
            contactdb.setValue(birthdate.text, forKey: "birthdate")
            contactdb.setValue(phone.text, forKey: "phone")
            contactdb.setValue(snapchat.text, forKey: "snapchat")
            
        }
        else
        {
            
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Contact",in: managedObjectContext)
            
            let contact = Contact(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            contact.name = name.text!
            contact.snapchat = snapchat.text!
            contact.phone = phone.text!
            contact.birthdate = birthdate.text!
        
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            //if error occurs
           // status.text = err.localizedFailureReason
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
        //**End Copy**
    }
    
    @IBAction func btnBack(_ sender: AnyObject) {
        
        //**Begin Copy**
        //2) Dismiss ViewController
       self.dismiss(animated: true, completion: nil)
//       let detailVC = ContactTableViewController()
//        detailVC.modalPresentationStyle = .fullScreen
//        present(detailVC, animated: false)
        //**End Copy**
    }
    
    //**Begin Copy**
    //3) Add ManagedObject Data Context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //**End Copy**
    
    
    //**Begin Copy**
    //4) Add variable contactdb (used from UITableView
    var contactdb:NSManagedObject!
    //**End Copy**
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //**Begin Copy**
        //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        
        
        if (contactdb != nil)
        {
            name.text = contactdb.value(forKey: "name") as? String
            birthdate.text = contactdb.value(forKey: "birthdate") as? String
            snapchat.text = contactdb.value(forKey: "snapchat") as? String
            phone.text = contactdb.value(forKey: "phone") as? String
            btnSave.setTitle("Update", for: UIControl.State())
           
            btnEdit.isHidden = false
            name.isEnabled = false
            snapchat.isEnabled = false
            birthdate.isEnabled = false
            phone.isEnabled = false
            btnSave.isHidden = true
        }else{
          
            btnEdit.isHidden = true
            name.isEnabled = true
            snapchat.isEnabled = true
            birthdate.isEnabled = true
            phone.isEnabled = true
        }
        name.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //**End Copy**
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //**Begin Copy**
    //6 Add to hide keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches , with:event)
        if (touches.first as UITouch?) != nil {
            DismissKeyboard()
        }
    }
    //**End Copy**
    
    
    //**Begin Copy**
    //7 Add to hide keyboard
    
    @objc func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        name.endEditing(true)
        snapchat.endEditing(true)
        birthdate.endEditing(true)
        phone.endEditing(true)
        
    }
    //**End Copy**
    
    //**Begin Copy**
    
    //8 Add to hide keyboard
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
    //**End Copy**
}

