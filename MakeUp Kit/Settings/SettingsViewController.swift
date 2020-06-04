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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func aboutAppButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://makeup-api.herokuapp.com")!)
    }
    @IBAction func aboutApiButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://makeup-api.herokuapp.com")!)
    }
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://makeup-api.herokuapp.com")!)
    }
    
    @IBAction func contactButtonTapped(_ sender: UIButton) {
        showMessageComposer()
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: ["http://makeup-api.herokuapp.com"], applicationActivities: nil)
        present(shareController, animated: true)
    }
    
    
//    func showMailComposer() {
//        guard MFMailComposeViewController.canSendMail() else {
//            return
//        }
//
//        let composer = MFMailComposeViewController()
//        composer.mailComposeDelegate = self
//        composer.setToRecipients(["huk@stud.onu.edu.ua"])
//        composer.setSubject("Course Work!!!")
//
//        present(composer, animated: true)
//    }
    
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
