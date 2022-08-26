//
//  ViewController.swift
//  SideMenu
//
//  Created by Игорь Островский on 26.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var menuTableView:UITableView!
    @IBOutlet var containerView:UIView!
    @IBOutlet var viewBG: UIImageView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    var menu = false
    let screen = UIScreen.main.bounds
    var home = CGAffineTransform()
    var options: [option] = [
        option(title: "Home", segue: "HomeSegue"),
        option(title: "Settings", segue: "Setingsegue"),
        option(title: "Profile", segue: "ProfileSegue"),
        option(title: "Terms and Conditions", segue: "TearmsSegue"),
        option(title: "Privacy Policy", segue: "PrivacySegue")
    ]
    struct option{
        var title = String()
        var segue = String()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.backgroundColor = .clear
        home = containerView.transform
    }
    
    func showMenu(){
        self.containerView.layer.cornerRadius = 40
        self.viewBG.layer.cornerRadius = self.containerView.layer.cornerRadius
        let x = screen.width * 0.8
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = scaledAndTranslatedTransform
        }
    }
    func hideMenu(){
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform  = self.home
            self.containerView.layer.cornerRadius = 0
            self.containerView.layer.cornerRadius = self.containerView.layer.cornerRadius
        }
    }
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        if menu == false && swipeGesture.direction == .right{
            showMenu()
            menu = true
        }
    }
    
    
    @IBAction func hideMenu(_ sender: Any) {
        if menu == true{
            hideMenu()
            menu = false
        }
    }
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)  as! tableViewCell
        cell.backgroundColor = .clear
        cell.descriptionLabel.text = options[indexPath.row].title
        cell.descriptionLabel.textColor = UIColor(cgColor: #colorLiteral(red: 0.4114302713, green: 0.8027595751, blue: 0.4050267193, alpha: 1))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  indexPath = tableView.indexPathForSelectedRow{
            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
            currentCell.alpha  = 0.5
            UIView.animate(withDuration: 1) {
                currentCell.alpha = 1
            }
            
            self.parent?.performSegue(withIdentifier: options[indexPath.row].segue, sender: self)
        }
    }
    
}
class tableViewCell:UITableViewCell{
    @IBOutlet var descriptionLabel:UILabel!
}
