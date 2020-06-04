//
//  SettingsViewController.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 03.06.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    let urlLink = URL(string: "http://makeup-api.herokuapp.com")!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func openUrl(url: URL) {
        UIApplication.shared.open(url)
    }
    
    @IBAction func aboutAppButtonTapped(_ sender: UIButton) {
        openUrl(url: urlLink)
    }
    @IBAction func aboutApiButtonTapped(_ sender: UIButton) {
        openUrl(url: urlLink)
    }
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        openUrl(url: urlLink)
    }
    
    @IBAction func contactButtonTapped(_ sender: UIButton) {
        showMessageComposer()
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: ["http://makeup-api.herokuapp.com"], applicationActivities: nil)
        present(shareController, animated: true)
    }
    
    func showMessageComposer() {
        
        guard MFMessageComposeViewController.canSendText() else {
            print("Message services are not available on this device.")
            return
        }
        let composer = MFMessageComposeViewController()
        composer.messageComposeDelegate = self
        composer.recipients = ["Alina Huk"]
        composer.subject = "Course Work!!!"
        present(composer, animated: true)
        
    }

}

extension SettingsViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) { }
}
