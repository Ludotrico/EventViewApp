//
//  ViewController.swift
//  EventView
//
//  Created by Ludovico Veniani on 1/20/21.
//

import UIKit
import KafkaRefresh

class ContainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        containerVC = self
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        padding = view.frame.width/30
        
        authorizeUser()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        configureNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logOutBtn.isHidden = false
    }
    
    
    //MARK: Variables
    var events = [Event]()
    
    
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
    
    let logOutBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log out", for: .normal)
        btn.titleLabel?.textColor = .systemRed
        btn.titleLabel?.font = smallFontBold
        btn.tintColor = .systemRed
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
      
        return btn
    }()
    
    
    
    //MARK: Helper Functions
    func authorizeUser() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            //Log user in
            configureViewComponents()
        } else {
            //Show Register page
            let authVC = AuthorizationVC()
            authVC.setup(isRegistration: true)
            navigationController?.pushViewController(authVC, animated: true)
        }
        
    }
    
    func configureViewComponents() {
        view.backgroundColor = .white
        
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
            self.getEvents(isRefreshing: true)
        }, themeColor: UIColor.systemBlue, refreshStyle: .replicatorDot)
        
        
        self.getEvents()
        
    }
    
    func configureNavigationBar() {
        title = "Events"
        

        logOutBtn.addTarget(self, action: #selector(logOutBtnTapped), for: .touchUpInside)
        
        navigationController!.navigationBar.addSubview(logOutBtn)
        logOutBtn.anchor(top: navigationController!.navigationBar.topAnchor, left: nil, bottom: navigationController!.navigationBar.bottomAnchor, right: navigationController!.navigationBar.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    }
    
    func getEvents(isRefreshing: Bool=false) {
        EventAPI.getEvents() { result in
            switch result {
                case .success(let events):
                    self.events = events
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
    @objc func logOutBtnTapped() {
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        UserDefaults.standard.setValue(nil, forKey: "username")
        UserDefaults.standard.setValue(nil, forKey: "password")
        

        UserDefaults.standard.set(nil, forKey: "attendanceDictionary")
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
    
        authorizeUser()
    }

}


//MARK: Delegates

extension ContainerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventVC = EventVC()
        let event = self.events[indexPath.row]
        eventVC.title = event.name
        eventVC.eventIndex = indexPath.row
        eventVC.setup(eventID: event.id)
        
        logOutBtn.isHidden = true
        navigationController?.pushViewController(eventVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell {
            cell.configureViewComponents(event: self.events[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    
}
