//
//  ViewController.swift
//  LocalAdmin
//
//  Created by Niyoosha T on 2022-06-19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    let screen = UIScreen.main.bounds
        var menu = false
        var home = CGAffineTransform()
    
    var options: [option] = [option(title: "Prom Summary", segue: "PromSummarySegue"),
                                 option(title: "Menu", segue: "MenuSegue"),
                                 option(title: "Seating Plan", segue: "SeatingSegue"),
                                 option(title: "Song Request", segue: "SongRequestSegue")
                                ]
        
        struct option {
            var title = String()
            var segue = String()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
                menuTableView.dataSource = self
                menuTableView.backgroundColor = .clear
        
        home = self.containerView.transform
        
    }
    
    func showMenu() {
            
            self.containerView.layer.cornerRadius = 40
            let x = screen.width * 0.8
            let originalTransform = self.containerView.transform
            let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
                let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
                UIView.animate(withDuration: 0.7, animations: {
                    self.containerView.transform = scaledAndTranslatedTransform
                    
                })
            
        }
        
        func hideMenu() {
            
                UIView.animate(withDuration: 0.7, animations: {
                    
                    self.containerView.transform = self.home
                    self.containerView.layer.cornerRadius = 0
                    
                })
            
        }
        
        
        
        @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
            
            print("menu interaction")
            
            if menu == false && swipeGesture.direction == .right {
                
                print("user is showing menu")
                
                showMenu()
                
                menu = true
                
            }
            
        }
        
    @IBAction func showMenuButton(_ sender: Any) {
        
        print("menu interaction")
        
        if menu == false && swipeGesture.direction == .right {
            
            print("user is showing menu")
            
            showMenu()
            
            menu = true
            
        }
    }
    
        
        @IBAction func hideMenu(_ sender: Any) {
            
            if menu == true {
                
                print("user is hiding menu")
                
                hideMenu()
                
                menu = false
                
            }
            
            
        }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return options.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
        cell.descriptionLabel.text = options[indexPath.row].title
        cell.descriptionLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let indexPath = tableView.indexPathForSelectedRow {

            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
            
            //animate the button when tapped
            
            currentCell.alpha = 0.5
            UIView.animate(withDuration: 1, animations: {
                currentCell.alpha = 1
            })
            
            //perform a segue when tapped
            
            self.parent?.performSegue(withIdentifier: options[indexPath.row].segue, sender: self)
            
        }
    }
    
}

class tableViewCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
    
}
