//
//  EventVC.swift
//  EventView
//
//  Created by Ludovico Veniani on 1/20/21.
//

import UIKit

class EventVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventVC = self
        
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerVC.logOutBtn.isHidden = true
    }
    
    
    //MARK: Variables
    var eventIndex: Int!
    var eventID: Int!
    var event: Event?
    
    
    //MARK: Views
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.isScrollEnabled =  true
        view.tag = 0
        return view
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .darkGray
        spinner.startAnimating()
        spinner.isHidden = false
        spinner.alpha = 1
        return spinner
    }()
    
    
    
    //MARK: Helper Functions
    func setup(eventID: Int) {
        view.backgroundColor = .white
        self.eventID = eventID
        
        configureTableView()
        
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0 , width: view.frame.width, height: 0)
        
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        
        tableView.separatorStyle = .none
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        
        
        tableView.bindHeadRefreshHandler( {
            self.getEvent(isRefreshing: true)
        }, themeColor: UIColor.systemBlue, refreshStyle: .replicatorDot)
        
        
        self.getEvent()
        
    }
    
    func configureNavigationBar() {
        title = event?.name
    }
    
    func getEvent(isRefreshing: Bool=false) {
        EventAPI.getEventDetails(eventID: self.eventID) { result in
            switch result {
            case .success(let event):
                self.event = event
                
                self.configureNavigationBar()
                
                self.tableView.reloadData()
                
                if isRefreshing {
                    self.tableView.headRefreshControl.endRefreshing()
                }
            case .failure(let error):
                print("DEBUG: \(error)")
                self.showMessage(message: "Oops, check your connection.")
            }
        }
    }
    
    func showMessage(message: String) {
        
        DispatchQueue.main.async {
            let label = self.createLbl(text: message)
            
            self.view.addSubview(label)
            label.alpha = 1
            
            label.frame = CGRect(x: 0 ,y: self.view.frame.height, width: (self.view.frame.width/4)*3, height: 50)
            label.center.x = self.view.center.x
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                label.frame = CGRect(x: 0, y: self.view.frame.height - 120, width: (self.view.frame.width/4)*3, height: 50)
                label.center.x = self.view.center.x
            }, completion: { _ in
                UIView.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    label.alpha = 0
                }, completion: { _ in
                    
                    label.removeFromSuperview()
                    label.alpha = 1
                })
            })
        }
        
    }
    
    func createLbl(text: String) -> UILabel {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.rgb(red: 209, green: 21, blue: 0)
        lbl.textColor = .white
        lbl.text = text
        lbl.font = smallFont //UIFont.italicSystemFont(ofSize: 15.0)
        //lbl.sizeToFit()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth  = true
        lbl.layer.cornerRadius = 10
        return lbl
    }
    
    //MARK: Selectors
    
    func markAttendance(cell: EventCell) {
        EventAPI.markAttendance(eventID: self.eventID) { result in
            switch result {
            case .success(let statusCode):
                if statusCode != 200 {
                    self.showMessage(message: "Oops, invalid event.")
                    cell.toggleAttendance(attend: false)
                    cell.configureAttendBtn()
                } else {
                    cell.toggleAttendance(attend: true)
                    cell.configureAttendBtn()
                    self.event?.attending += 1
                    
                    self.tableView.reloadData()
                    
                    //Update containerVC
                    containerVC.events[self.eventIndex].attending += 1
                    containerVC.tableView.reloadRows(at: [IndexPath(row: self.eventIndex, section: 0)], with: .none)

                }
            case .failure(let error):
                print("DEBUG: \(error)")
                self.showMessage(message: "Oops, check your connection.")
                
            }
        }
    }
    
    
    
    
}

//MARK: Delegates
extension EventVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell {
            cell.configureViewComponents(event: event!, isDetailedView: true)
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    
}
