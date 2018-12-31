//
//  SpaceDetailsViewController.swift
//  Lofti
//
//  Created by Medi Assumani on 11/7/18.
//  Copyright © 2018 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class SpaceDetailsViewController: UIViewController{
    
    var mainStackView = CustomStackView()
    var isOpenAndWifiStackView = CustomStackView()
    var actionButtonsStackView = CustomStackView()
    var spaceNameLabel = CustomLabel()
    var isOpenLabel = UILabel()
    var currentWeatherLabel = CustomLabel()
    var getDirectionsButton = CustomButton()
    var contactButton = CustomButton()
    var wifiImage = UIImageView(image: UIImage(named: "wifi"))
    var space: Space?
    let homepage = HomePageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpSpaceNameLabel()
        setUpIsOpenLabel()
        setUpcurrentWeatherLabel()
        setUpContactButton()
        setUpGetDirectionsButton()
        setUpActionButtonsStack()
        mainStakViewAutoLayout()
    }
    

    
    //USER INTERFACE
    
    private func setUpSpaceNameLabel(){
        
        spaceNameLabel = CustomLabel(fontSize: 22,
                                     text: space?.name ?? "Unknown",
                                     textColor: .black,
                                     textAlignment: .center,
                                     fontName: "HelveticaNeue-Bold")
        
    }
    
    private func setUpIsOpenLabel(){
        
        let wifiStatusLabel = CustomLabel(fontSize: 15,
                                          text: "WIFI Available",
                                          textColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),
                                          textAlignment: .center,
                                          fontName: "HelveticaNeue-Light")
        
        let wifiStack = CustomStackView(subviews: [wifiImage, wifiStatusLabel],
                                        alignment: .center,
                                        axis: .horizontal,
                                        distribution: .fillEqually)
        
        
        isOpenAndWifiStackView = CustomStackView(subviews: [isOpenLabel, wifiStack],
                                        alignment: .center,
                                        axis: .horizontal,
                                        distribution: .fillEqually)
        
        if space?.hours?.first?.is_open_now == true{
            
            isOpenLabel.text = "Open"
            isOpenLabel.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            isOpenLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        }else{
            
            isOpenLabel.text = "Closed"
            isOpenLabel.textColor = .red
            isOpenLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        }
        
        NSLayoutConstraint.activate([isOpenLabel.heightAnchor.constraint(equalTo: isOpenAndWifiStackView.heightAnchor, multiplier: 0.4),
                                     isOpenLabel.widthAnchor.constraint(equalTo: isOpenAndWifiStackView.widthAnchor, multiplier: 0.6),
                                     wifiStack.heightAnchor.constraint(equalTo: isOpenAndWifiStackView.heightAnchor, multiplier: 0.55),
                                     wifiStack.widthAnchor.constraint(equalTo: isOpenAndWifiStackView.widthAnchor, multiplier: 0.4)])
        
    }
    
    private func setUpcurrentWeatherLabel(){
        
        currentWeatherLabel = CustomLabel(fontSize: 19,
                                       text: "85°FAHRENHEIT",
                                       textColor: .black,
                                       textAlignment: .center,
                                       fontName: "HelveticaNeue-Bold")
    }
    
    private func setUpActionButtonsStack(){
        
        actionButtonsStackView = CustomStackView(subviews: [contactButton, getDirectionsButton],
                                                 alignment: .center,
                                                 axis: .vertical,
                                                 distribution: .fillEqually)
    }
    
    private func setUpGetDirectionsButton(){
        
        getDirectionsButton = CustomButton(title: "Get Directions",
                                           fontSize: 15,
                                           titleColor: .black,
                                           target: self,
                                           action: #selector(directionsButtonTapped(_:)),
                                           event: .touchUpInside)
        
        getDirectionsButton.layer.shadowRadius = 1
    }
    
    private func setUpContactButton(){
        
        contactButton = CustomButton(title: "Contact",
                                     fontSize: 23, titleColor: .black,
                                     target: self,
                                     action: #selector(contactButtonIsTapped(_:)),
                                     event: .touchUpInside)
        
        contactButton.layer.shadowRadius = 1
    }
    
    
    private func mainStakViewAutoLayout(){
        
        mainStackView = CustomStackView(subviews: [spaceNameLabel,isOpenAndWifiStackView,currentWeatherLabel,actionButtonsStackView],
                                        alignment: .center,
                                        axis: .vertical,
                                        distribution: .fill)
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
                                     mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.95),
                                     spaceNameLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.09),
                                     isOpenAndWifiStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1),
                                     isOpenAndWifiStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.7),
                                     currentWeatherLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.38),
                                     currentWeatherLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1),
                                     actionButtonsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.7),
                                     actionButtonsStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1)])
    }
    
    
    
    @objc private func directionsButtonTapped(_ sender: UIButton){
        
        
        guard let longitude = space?.longitude, let latitude = space?.latitude else {return}
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let placeMark = MKPlacemark(coordinate: coordinates)
        let regionSpan = MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: longitude)
        let mapItems = MKMapItem(placemark: placeMark)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinateSpan: regionSpan), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan)]
        
        mapItems.name = space?.name
        mapItems.openInMaps(launchOptions: options)
    }
    
    @objc private func contactButtonIsTapped(_ sender: UIButton){
        
    }
    
}

