//
//  ViewController.swift
//  koNpassi
//
//  Created by Jonne Itkonen on 27.5.2017.
//
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var direction: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!

    var location : CLLocation?
    @IBOutlet weak var konpassi: KoNpassiView!
    var manager : CLLocationManager?

    private let sfmt = MeasurementFormatter()
    private let lfmt = LengthFormatter()
    private var canCalibrate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        manager!.requestWhenInUseAuthorization()
        manager!.delegate = self
        manager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation //HundredMeters
        manager!.distanceFilter = 5 // meters
        //print("distanceFilter -> \(manager!.distanceFilter) \(kCLDistanceFilterNone)")
        manager!.startUpdatingLocation()
        manager!.startUpdatingHeading()
        manager!.startMonitoringSignificantLocationChanges()
        //view = KoNpassiView()
        let r = CGAffineTransform(rotationAngle: 0.707)
        konpassi.transform = r
        canCalibrate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let spd = Measurement(
                value: (location.speed * 3600.0) / 1000.0,
                unit: UnitSpeed.kilometersPerHour)

            speed.text = sfmt.string(from: spd) //"\(spd) km/h"

            let alt = location.altitude
            altitude.text = lfmt.string(fromMeters: alt)

            let lng = Measurement(value: location.coordinate.longitude, unit: UnitAngle.degrees)
            longitude.text = sfmt.string(from: lng) // "\(location.coordinate.longitude)"
            let lat = Measurement(value: location.coordinate.latitude, unit: UnitAngle.degrees)
            latitude.text = sfmt.string(from: lat)

        } else {
            altitude.text = " -- "
            speed.text = " -- "
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let degs = Measurement(value: newHeading.trueHeading,
                               unit: UnitAngle.degrees) // Int(newHeading.trueHeading);
        direction.text = sfmt.string(from: degs) // "\(degs)°"
        let r = CGAffineTransform(rotationAngle: CGFloat(-Double.pi - degs.converted(to: UnitAngle.radians).value))
        konpassi.transform = r
    }

    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return canCalibrate
    }
}

