//
//  FirstViewController.swift
//  To_do_List
//
//  Created by Alexandre Henrique Silva on 09/03/18.
//  Copyright © 2018 Alexhenri. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadList), name: NSNotification.Name(rawValue: "load"), object: nil)

        guard UserDefaults.standard.object(forKey: "arrayList") != nil else {
            let arrayList = [String]()
            UserDefaults.standard.set(arrayList, forKey: "arrayList")
            return
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func reloadList(notification: NSNotification) {
    
        listTableView.reloadData()
        
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arrayListObject = UserDefaults.standard.object(forKey: "arrayList") else {
            print("Error \(#line): Cannot access the user default array list")
            return 0
        }
        
        if let arrayList = arrayListObject as? Array<String> {
            return arrayList.count
        }
        print("Error \(#line): Cannot identify the array list as a string array")
        return  0
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")

        guard let arrayListObject = UserDefaults.standard.object(forKey: "arrayList") else {
            return cell
        }
        
        if let arrayList = arrayListObject as? Array<String> {
            cell.textLabel?.text = arrayList[indexPath.row]
            cell.textLabel?.font = UIFont(name:"Party LET", size:30)
        
        }
        

        return cell
        
    }
    
}

