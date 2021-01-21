//
//  EventCell.swift
//  EventView
//
//  Created by Ludovico Veniani on 1/20/21.
//

import UIKit

class EventCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    //MARK: Variables
    var event: Event!
    
    
    //MARK: Views
    var HostVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.addBackground(color: UIColor.lightGray.withAlphaComponent(0.3), cornerRadius: 25)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = padding/2
        
        return stack
    }()
    
    var titleLbl: UILabel = {
        var label = UILabel()
        label.font = largeFontBold //UIFont(name: "BrandonGrotesque-Light", size: 18)//UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    
    var locationLbl: UILabel = {
        var label = UILabel()
        label.font = mediumFont //UIFont(name: "BrandonGrotesque-Light", size: 18)//UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    var startLbl: UILabel = {
        var label = UILabel()
        label.font = mediumFont //UIFont(name: "BrandonGrotesque-Light", size: 18)//UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    var endLbl: UILabel = {
        var label = UILabel()
        label.font = mediumFont //UIFont(name: "BrandonGrotesque-Light", size: 18)//UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    
    var attendingLbl: UILabel = {
        var label = UILabel()
        label.font = mediumFont //UIFont(name: "BrandonGrotesque-Light", size: 18)//UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var attendBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(attendBtnTapped), for: .touchUpInside)
        btn.layer.cornerRadius = padding
        return btn
    }()
    
    
    
    //MARK: Helper Functions
    func configureViewComponents(event: Event, isDetailedView: Bool=false) {
        self.event = event
        
        selectionStyle = .none
        backgroundColor = .white
        
        
        contentView.addSubview(HostVStack)
        HostVStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding)
        
        HostVStack.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        HostVStack.isLayoutMarginsRelativeArrangement = true
        
        HostVStack.addArrangedSubview(titleLbl)
        titleLbl.widthAnchor.constraint(lessThanOrEqualToConstant: 1000).isActive = true
        titleLbl.heightAnchor.constraint(lessThanOrEqualToConstant: 1000).isActive = true
        titleLbl.text = event.name
        
        HostVStack.addArrangedSubview(locationLbl)
        var attributedText = NSMutableAttributedString(string: "Location:  ", attributes: [NSAttributedString.Key.font: mediumFontBold, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: "\(event.location)", attributes: [NSAttributedString.Key.font: mediumFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray,]))
        locationLbl.attributedText = attributedText
        
        HostVStack.addArrangedSubview(startLbl)
        attributedText = NSMutableAttributedString(string: "Start:  ", attributes: [NSAttributedString.Key.font: mediumFontBold, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: "\(event.getDate(getStart: true))", attributes: [NSAttributedString.Key.font: mediumFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray,]))
        startLbl.attributedText =  attributedText
        
        HostVStack.addArrangedSubview(endLbl)
        attributedText = NSMutableAttributedString(string: "End:  ", attributes: [NSAttributedString.Key.font: mediumFontBold, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: "\(event.getDate(getStart: false))", attributes: [NSAttributedString.Key.font: mediumFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray,]))
        endLbl.attributedText = attributedText
        
        HostVStack.addArrangedSubview(attendingLbl)
        attributedText = NSMutableAttributedString(string: "Attending:  ", attributes: [NSAttributedString.Key.font: mediumFontBold, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: "\(event.attending)", attributes: [NSAttributedString.Key.font: mediumFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray,]))
        attendingLbl.attributedText = attributedText
        
        
        if isDetailedView {
            HostVStack.addArrangedSubview(attendBtn)
            configureAttendBtn()
            
        }
        
        
        
    }
    
    func configureAttendBtn() {
        if let attendanceDict = UserDefaults.standard.dictionary(forKey: "attendanceDictionary") {
            if attendanceDict[String(event.id)] != nil {
                //User marked attendance
                attendBtn.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: {
                    
                    self.attendBtn.setTitle("     Attending     ", for: .normal)
                    self.attendBtn.backgroundColor = .systemBlue
                    self.attendBtn.tintColor = .white
                    self.attendBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
                
                
                return
            }
        }
        
        //User has not marked attendance
        attendBtn.setTitle("Attend", for: .normal)
        attendBtn.backgroundColor = .clear
        attendBtn.titleLabel?.textColor = .systemBlue
    }
    
    func toggleAttendance(attend: Bool) {
        
        if attend {
            // add to attendanceDict
            if var attendanceDict = UserDefaults.standard.dictionary(forKey: "attendanceDictionary") {
                attendanceDict[String(event.id)] = true
                UserDefaults.standard.set(attendanceDict, forKey: "attendanceDictionary")
            } else {
                UserDefaults.standard.set([String(event.id): true], forKey: "attendanceDictionary")
            }
        } else {
            // remove from attendanceDict
            if var attendanceDict = UserDefaults.standard.dictionary(forKey: "attendanceDictionary") {
                attendanceDict[String(event.id)] = nil
                UserDefaults.standard.set(attendanceDict, forKey: "attendanceDictionary")
            }
        }
    }
    
    
    //MARK: Selectors
    @objc func attendBtnTapped() {
        if let attendanceDict = UserDefaults.standard.dictionary(forKey: "attendanceDictionary") {
            if attendanceDict[String(event.id)] == nil {
                eventVC.markAttendance(cell: self)
            }
        } else {
            eventVC.markAttendance(cell: self)
        }
    }
}
