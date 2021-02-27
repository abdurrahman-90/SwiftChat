//
//  MessageViewController.swift
//  SwiftChat
//
//  Created by Akdag on 27.02.2021.
//

import UIKit
import Firebase
import Baraba
import IQKeyboardManagerSwift

class MessageViewController: UIViewController {
    @IBOutlet weak var barabaBarBtn: UIBarButtonItem!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var tableView: UITableView!
   
    let db = Firestore.firestore()
    var message : [Message] = []
    private var baraba : Baraba?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = A.appName
        navigationItem.hidesBackButton = true
        barabaBarBtn?.title = "Pause"
        baraba = Baraba(configuration: .automatic)
        baraba?.scrollView = tableView
        baraba?.delegate = self
        baraba?.resume()
        tableView?.register(UINib(nibName: A.cellNibName, bundle: nil), forCellReuseIdentifier: A.cellIdentifier)

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        loadMessage()
    }
    func loadMessage(){
        db.collection(A.FStore.collectionName).order(by: A.FStore.dateField)
            .addSnapshotListener { (querySnapchat, error) in
                self.message = []
                if let error = error {
                    print("System Error : \(error)")
                }else{
                    if let snapShotDocuments = querySnapchat?.documents{
                        for document in snapShotDocuments{
                            let data = document.data()
                            if let messageSender = data[A.FStore.senderField] as? String , let messageBody = data[A.FStore.bodyField] as? String    {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.message.append(newMessage)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPAth = IndexPath(row: self.message.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPAth, at: .bottom, animated: true)
                                }
                            }
                        }
                    }
                }
            
            }
        
    }
    
    
    @IBAction func SendBtn(_ sender: UIButton) {
        if let messageBody = messageText.text , let messageSender = Auth.auth().currentUser?.email{
            db.collection(A.FStore.collectionName).addDocument(data: [
                A.FStore.senderField : messageSender,
                A.FStore.bodyField : messageBody,
                A.FStore.dateField : Date().timeIntervalSince1970
            ]){(error) in
                if let error = error {
                    print("System Error: \(error)")
                    
                }else{
                   
                     DispatchQueue.main.async {
                         self.messageText.text = ""
                     }
                     
                   
                }
                
            }
        }
    }
    
    @IBAction func logOutBarBtn(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch {
            print(error)
        }
    }
    
    @IBAction func barabaBtn(_ sender: UIBarButtonItem) {
        if baraba?.isActive == true {
            sender.title = "Enable"
            baraba?.pause()
        }else{
            sender.title = "Pause"
            baraba?.resume()
        }
    }
    
}
extension MessageViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: A.cellIdentifier, for: indexPath) as! MessageViewCell
        let messages = message[indexPath.row]
        cell.Label.text = messages.body
        if messages.sender == Auth.auth().currentUser?.email{
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: A.BrandColors.lighPink)
            cell.Label.textColor = UIColor(named: A.BrandColors.purple)
        }else{
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: A.BrandColors.purple)
            cell.Label.textColor = UIColor(named: A.BrandColors.lighPink)
        }
        
        return cell
    }
}
extension MessageViewController : UITableViewDelegate{
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            message.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        tableView.reloadData()
    }
}
extension MessageViewController : BarabaDelegate{
    func baraba(_ baraba: Baraba, didFailWithError error: Error) {
        switch error {
        case BarabaError.cameraUnauthorized:
            ()
        case BarabaError.unsupportedConfiguration :
            ()
        default:
            ()
        }
    }
}
