//
//  ViewSpaceViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/7/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

class ViewSpaceViewController: UIViewController{
    
    var mainStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpMainStackView()
    }
    
    
    
    //USER INTERFACE
    
    
    // The textview to show the name of the space
    private let spaceNameTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Manzanita Macaroon",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18)])
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // The textview to show the renting price
    private let rentingPriceTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    // The textview to show the description of the place
    private let spaceDescriptionTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    // The textview to show the time availability of the place
    private let timeAvailabilityTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    private let spaceImagesContainerView: UIView = {
       
        let view = UIView()
        
        return view
    }()
    
    private let rentButton: UIButton = {
        
        let button = UIButton()
        
        return button
    }()
    
    fileprivate func setUpMainStackView(){
        
        mainStackView = UIStackView(arrangedSubviews: [spaceNameTextView,
                                                       rentingPriceTextView,
                                                       spaceDescriptionTextView,
                                                       timeAvailabilityTextView,
                                                       spaceImagesContainerView,
                                                       rentButton])
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
}