//
//  ViewController.swift
//  Geolocalisation3-4
//
//  Created by Etienne Payet on 07/10/2018.
//  Copyright © 2018 Etienne Payet. All rights reserved.
//

import UIKit
import MapKit

class LocalisationView: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var annotationTextField: UITextField!
    @IBOutlet weak var worldView: MKMapView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            
            locationManager.requestWhenInUseAuthorization()
            
            worldView.showsUserLocation = true
        }
        else {
            let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error"),
                                          message: NSLocalizedString("location not enabled", comment: "Error"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func whereAmI(_ sender: Any) {
        
            print("current location is nil")
            let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error"),
                                          message: NSLocalizedString("unknown", comment: "Error"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func standard(_ sender: Any) {
        worldView.mapType = .standard
    }
    
    @IBAction func satellite(_ sender: Any) {
        worldView.mapType = .satellite
    }
    
    @IBAction func hybrid(_ sender: Any) {
        worldView.mapType = .hybrid
    }
    
    /***************************************
     * Protocole CLLocationManagerDelegate *
     ***************************************/
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    /*******************************
     * Protocole MKMapViewDelegate *
     *******************************/
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        currentLocation = userLocation.location
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: "Error"),
                                      message: NSLocalizedString("failed to update map", comment: "Error"),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            // Si l'annotation se trouve sur la position de l'utilisateur,
            // on retourne 'nil' pour qu'un point bleu s'affiche au lieu
            // d'une épingle
            return nil
        }
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "dmi")
        pin.pinTintColor = UIColor.red
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annonation = view.annotation {
            var latitude = annonation.coordinate.latitude
            var latitudeString = NSLocalizedString("north", comment: "Label")
            if latitude < 0 {
                latitude = -1 * latitude
                latitudeString = NSLocalizedString("south", comment: "Label")
            }
            var longitude = annonation.coordinate.longitude
            var longitudeString = NSLocalizedString("east", comment: "Label")
            if longitude < 0 {
                longitude = -1 * longitude
                longitudeString = NSLocalizedString("west", comment: "Label")
            }
            annotationTextField.text = String(format: "%@: %.3f %@, %.3f %@",
                                              NSLocalizedString("location", comment: "Label"),
                                              latitude, latitudeString, longitude, longitudeString)
        }
    }
    
    /*********************************
     * Protocole UITextFieldDelegate *
     *********************************/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

