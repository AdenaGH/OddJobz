//
//  MapViewController.m
//  OddJobz
//
//  Created by Adena Rowana Ninvalle on 7/22/21.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <CLLocationManagerDelegate>
@property CLLocationManager *manager;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    //[self.manager requestWhenInUseAuthorization];
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];
    
    
    // Do any additional setup after loading the view.

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    if (location == nil) {
        NSLog(@"Help wanted");
    }
    
    CLLocationCoordinate2D coord = location.coordinate;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coord.latitude
                                                            longitude:coord.longitude
                                                                 zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];

    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(coord.latitude, coord.longitude);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
    
    
    [self.manager stopUpdatingLocation];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
