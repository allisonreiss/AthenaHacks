//
//  ListOfCharitesVC.swift
//  AthenaHacks
//
//  Created by Sarah Gemperle on 2/25/18.
//  Copyright © 2018 Allison Reiss. All rights reserved.
//

import UIKit
import Firebase

class ListOfCharitesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref: DatabaseReference!
    var gradient: CAGradientLayer!
    
    @IBOutlet weak var tableView: UITableView!
    var categorySelected: String?
    var list: NSArray?
    var userUID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.estimatedRowHeight = 140

        self.tableView.layoutSubviews()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set up the background gradient
        gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        let colorTop = UIColor(red: 166.0 / 255.0, green: 237.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 69.0 / 255.0, green: 247.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorTop, colorBottom]
        gradient.zPosition = -1
        self.view.layer.addSublayer(gradient)
        
        
        if let categorySelected = categorySelected {
            let apikey = "6036d915f121c7d50b8f3d7bcc93796f"
            let url = URL(string: "https://data.orghunter.com/v1/charitysearch?user_key=\(apikey)&category=\(categorySelected)")
            let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            
            let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if let data = data {
                    if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                        self.list = dataDictionary["data"] as! NSArray
                        print(dataDictionary)
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharityCell") as! CharityCell
        
        if let list = list {
            let charity = list[indexPath.row] as! NSDictionary
            cell.nameLabel.text = charity["charityName"] as? String
            cell.charity = charity
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.list {
            return list.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = list {
            let charity = list[indexPath.row] as! NSDictionary
            let charityName = charity["charityName"] as? String
            
            //self.ref.child("users").child(self.userUID!).setValue(["charity": charityName])
            let alertController = UIAlertController(title: "Saved!",
                                                    message: "You selected \(charityName!) as your charity!",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.performSegue(withIdentifier: "toMapSegue", sender: self)
            })
            present(alertController, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
