//
//  ProfileViewController.swift
//  AthenaHacks
//
//  Created by Allison Reiss on 2/24/18.
//  Copyright © 2018 Allison Reiss. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var charityLabel: UILabel!
    @IBOutlet weak var changeCharityButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var milesTilDonateLabel: UILabel!
    @IBOutlet weak var donateNowButton: UIButton!
    @IBOutlet weak var totalMilesLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    
    var gradient : CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        changeCharityButton.layer.cornerRadius = 15
        changeCharityButton.clipsToBounds = true
        donateNowButton.layer.cornerRadius = 15
        donateNowButton.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
        // Set up the background gradient
        gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        let colorTop = UIColor(red: 166.0 / 255.0, green: 237.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 69.0 / 255.0, green: 247.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorTop, colorBottom]
        gradient.zPosition = -1
        self.view.layer.addSublayer(gradient)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChangeCharity(_ sender: Any) {
        performSegue(withIdentifier: "chooseNewCharity", sender: nil)
    }
    

}
