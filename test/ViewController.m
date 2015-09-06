//
//  ViewController.m
//  test
//
//  Created by yi chen on 14-8-20.
//  Copyright (c) 2014年 yi chen. All rights reserved.
//

#import "ViewController.h"
#import "MAMapKit.h"
#import "MovingAnnotationView.h"
#import "TracingPoint.h"
#import "Util.h"

@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView * map;

@property (nonatomic, strong) MAPointAnnotation * car;
@property (nonatomic, strong) MAPointAnnotation * car1;
@property (nonatomic, strong) MAPointAnnotation * car2;

@property (nonatomic, strong) UILabel* speedLabel;
@end

@implementation ViewController
{
    CFTimeInterval _durationBaseForSpeed;
    NSMutableArray * _tracking;
    CFTimeInterval _duration;
    int carCount;
    NSMutableArray* annotationArray;
    NSMutableArray * _tracking1;
    CFTimeInterval _duration1;
    int carCount1;
    NSMutableArray* annotationArray1;

    NSMutableArray * _tracking2;
    CFTimeInterval _duration2;
    int carCount2;
    NSMutableArray* annotationArray2;
}

#pragma mark - trackings

- (void)initRoute
{
    _durationBaseForSpeed = 10.0;
    _duration = 10.0;
    _duration1 = 10.0;
    _duration2 = 10.0;
    carCount = 3;
    carCount1 = 3;
    carCount2 = 3;
    annotationArray = [[NSMutableArray alloc] init];
    annotationArray1 = [[NSMutableArray alloc] init];
    annotationArray2 = [[NSMutableArray alloc] init];
    
#if 0
    NSUInteger count = 14;
    CLLocationCoordinate2D * coords = malloc(count * sizeof(CLLocationCoordinate2D));

    coords[0] = CLLocationCoordinate2DMake(39.93563,  116.387358);
    coords[1] = CLLocationCoordinate2DMake(39.935564,   116.386414);
    coords[2] = CLLocationCoordinate2DMake(39.935646,  116.386038);
    coords[3] = CLLocationCoordinate2DMake(39.93586, 116.385791);
    coords[4] = CLLocationCoordinate2DMake(39.93586, 116.385791);
    coords[5] = CLLocationCoordinate2DMake(39.937983, 116.38474);
    coords[6] = CLLocationCoordinate2DMake(39.938616, 116.3846);
    coords[7] = CLLocationCoordinate2DMake(39.938888, 116.386971);
    coords[8] = CLLocationCoordinate2DMake(39.938855, 116.387047);
    coords[9] = CLLocationCoordinate2DMake(39.938172,  116.387132);
    coords[10] = CLLocationCoordinate2DMake(39.937604, 116.387218);
    coords[11] = CLLocationCoordinate2DMake(39.937489, 116.387132);
    coords[12] = CLLocationCoordinate2DMake(39.93614,  116.387283);
    coords[13] = CLLocationCoordinate2DMake(39.935622,  116.387347);
#else
    NSUInteger count = 14;
    CLLocationCoordinate2D * coords = malloc(count * sizeof(CLLocationCoordinate2D));

    coords[0] = CLLocationCoordinate2DMake(39.93563,  116.387358);
    coords[1] = CLLocationCoordinate2DMake(39.935564,   116.386414);
    coords[2] = CLLocationCoordinate2DMake(39.935646,  116.386038);
    coords[3] = CLLocationCoordinate2DMake(39.93586, 116.385791);
    coords[4] = CLLocationCoordinate2DMake(39.937983, 116.38474);
    coords[5] = CLLocationCoordinate2DMake(39.938616, 116.3846);
    coords[6] = CLLocationCoordinate2DMake(39.938888, 116.386971);
    coords[7] = CLLocationCoordinate2DMake(39.938855, 116.387047);
    coords[8] = CLLocationCoordinate2DMake(39.938172,  116.387132);
    coords[9] = CLLocationCoordinate2DMake(39.937604, 116.387218);
    coords[10] = CLLocationCoordinate2DMake(39.937489, 116.387132);
    coords[11] = CLLocationCoordinate2DMake(39.93614,  116.387283);
    coords[12] = CLLocationCoordinate2DMake(39.935622,  116.387347);
    coords[13] = CLLocationCoordinate2DMake(39.93563,  116.387358);

    //平移lat
//    NSUInteger count1 = 13;
//    CLLocationCoordinate2D * coords1 = malloc(count1 * sizeof(CLLocationCoordinate2D));
//    coords1[0] = CLLocationCoordinate2DMake(39.93664,  116.387358);
//    coords1[1] = CLLocationCoordinate2DMake(39.936565,   116.386414);
//    coords1[2] = CLLocationCoordinate2DMake(39.936647,  116.386038);
//    coords1[3] = CLLocationCoordinate2DMake(39.93687, 116.385791);
//    coords1[4] = CLLocationCoordinate2DMake(39.938984, 116.38474);
//    coords1[5] = CLLocationCoordinate2DMake(39.939617, 116.3846);
//    coords1[6] = CLLocationCoordinate2DMake(39.939889, 116.386971);
//    coords1[7] = CLLocationCoordinate2DMake(39.939856, 116.387047);
//    coords1[8] = CLLocationCoordinate2DMake(39.939173,  116.387132);
//    coords1[9] = CLLocationCoordinate2DMake(39.938605, 116.387218);
//    coords1[10] = CLLocationCoordinate2DMake(39.938480, 116.387132);
//    coords1[11] = CLLocationCoordinate2DMake(39.93715,  116.387283);
//    coords1[12] = CLLocationCoordinate2DMake(39.936623,  116.387347);

    NSUInteger count1 = 19;
    CLLocationCoordinate2D * coords1 = malloc(count1 * sizeof(CLLocationCoordinate2D));
    coords1[0] = CLLocationCoordinate2DMake(39.938888, 116.386971);
    coords1[1] = CLLocationCoordinate2DMake(39.938855, 116.387047);
    coords1[2] = CLLocationCoordinate2DMake(39.938184, 116.387118);//+
    coords1[3] = CLLocationCoordinate2DMake(39.938104, 116.388332);//+
    coords1[4] = CLLocationCoordinate2DMake(39.937634, 116.388302);//+
    coords1[5] = CLLocationCoordinate2DMake(39.937534, 116.388202);//+
    coords1[6] = CLLocationCoordinate2DMake(39.936524, 116.388132);//+
    coords1[7] = CLLocationCoordinate2DMake(39.936434, 116.388198);//+
    coords1[8] = CLLocationCoordinate2DMake(39.93565,  116.388158);//+
    coords1[9] = CLLocationCoordinate2DMake(39.93563,  116.387358);
    coords1[10] = CLLocationCoordinate2DMake(39.935564,   116.386414);
    coords1[11] = CLLocationCoordinate2DMake(39.935646,  116.386038);
    coords1[12] = CLLocationCoordinate2DMake(39.93586, 116.385791);
    coords1[13] = CLLocationCoordinate2DMake(39.93578, 116.38550);//+
    coords1[14] = CLLocationCoordinate2DMake(39.93698, 116.38477);//+
    coords1[15] = CLLocationCoordinate2DMake(39.937883, 116.38464);//+
    coords1[16] = CLLocationCoordinate2DMake(39.937983, 116.38474);
    coords1[17] = CLLocationCoordinate2DMake(39.938616, 116.3846);
    coords1[18] = CLLocationCoordinate2DMake(39.938888, 116.386971);

//开始点扩展
//    coords1[0] = CLLocationCoordinate2DMake(39.93565,  116.388158);//+
//    coords1[1] = CLLocationCoordinate2DMake(39.93563,  116.387358);
//    coords1[2] = CLLocationCoordinate2DMake(39.935564,   116.386414);
//    coords1[3] = CLLocationCoordinate2DMake(39.935646,  116.386038);
//    coords1[4] = CLLocationCoordinate2DMake(39.93586, 116.385791);
//    coords1[5] = CLLocationCoordinate2DMake(39.93578, 116.38550);//+
//    coords1[6] = CLLocationCoordinate2DMake(39.93698, 116.38477);//+
//    coords1[7] = CLLocationCoordinate2DMake(39.937883, 116.38464);//+
//    coords1[8] = CLLocationCoordinate2DMake(39.937983, 116.38474);
//    coords1[9] = CLLocationCoordinate2DMake(39.938616, 116.3846);
//    coords1[10] = CLLocationCoordinate2DMake(39.938888, 116.386971);
//    coords1[11] = CLLocationCoordinate2DMake(39.938855, 116.387047);
//    coords1[12] = CLLocationCoordinate2DMake(39.938184, 116.387118);//+
//    coords1[13] = CLLocationCoordinate2DMake(39.938104, 116.388332);//+
//    coords1[14] = CLLocationCoordinate2DMake(39.937634, 116.388302);//+
//    coords1[15] = CLLocationCoordinate2DMake(39.937534, 116.388202);//+
//    coords1[16] = CLLocationCoordinate2DMake(39.936524, 116.388132);//+
//    coords1[17] = CLLocationCoordinate2DMake(39.936434, 116.388198);//+
//    coords1[18] = CLLocationCoordinate2DMake(39.93565,  116.388158);//+

    [self showRouteForCoords:coords1 count:count1];
    [self initTrackingWithCoords1:coords1 count:count1];
    
    if (coords1) {
        free(coords1);
    }

    NSUInteger count2 = 19;
    CLLocationCoordinate2D * coords2 = malloc(count2 * sizeof(CLLocationCoordinate2D));
    coords2[18] = CLLocationCoordinate2DMake(39.938616, 116.3846);
    coords2[17] = CLLocationCoordinate2DMake(39.938888, 116.386971);
    coords2[16] = CLLocationCoordinate2DMake(39.938855, 116.387047);
    coords2[15] = CLLocationCoordinate2DMake(39.938184, 116.387118);//+
    coords2[14] = CLLocationCoordinate2DMake(39.938104, 116.388332);//+
    coords2[13] = CLLocationCoordinate2DMake(39.937634, 116.388302);//+
    coords2[12] = CLLocationCoordinate2DMake(39.937534, 116.388202);//+
    coords2[11] = CLLocationCoordinate2DMake(39.936524, 116.388132);//+
    coords2[10] = CLLocationCoordinate2DMake(39.936434, 116.388198);//+
    coords2[9] = CLLocationCoordinate2DMake(39.93565,  116.388158);//+
    coords2[8] = CLLocationCoordinate2DMake(39.93563,  116.387358);
    coords2[7] = CLLocationCoordinate2DMake(39.935564,   116.386414);
    coords2[6] = CLLocationCoordinate2DMake(39.935646,  116.386038);
    coords2[5] = CLLocationCoordinate2DMake(39.93586, 116.385791);
    coords2[4] = CLLocationCoordinate2DMake(39.93578, 116.38550);//+
    coords2[3] = CLLocationCoordinate2DMake(39.93698, 116.38477);//+
    coords2[2] = CLLocationCoordinate2DMake(39.937883, 116.38464);//+
    coords2[1] = CLLocationCoordinate2DMake(39.937983, 116.38474);
    coords2[0] = CLLocationCoordinate2DMake(39.938616, 116.3846);

    [self showRouteForCoords:coords2 count:count2];
    [self initTrackingWithCoords2:coords2 count:count2];
    
    if (coords2) {
        free(coords2);
    }

#endif

    [self showRouteForCoords:coords count:count];
    [self initTrackingWithCoords:coords count:count];
    
    if (coords) {
        free(coords);
    }

}

- (void)showRouteForCoords:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
{
    //show route
//    MAPolyline *route = [MAPolyline polylineWithCoordinates:coords count:count];
//    [self.map addOverlay:route];
    
    NSMutableArray * routeAnno = [NSMutableArray array];
    for (int i = 0 ; i < count; i++)
    {
        MAPointAnnotation * a = [[MAPointAnnotation alloc] init];
        a.coordinate = coords[i];
        a.title = @"route";
        [routeAnno addObject:a];
    }
//    [self.map addAnnotations:routeAnno];
    [self.map showAnnotations:routeAnno animated:NO];

}

- (void)initTrackingWithCoords:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
{
    _tracking = [NSMutableArray array];
    for (int i = 0; i<count - 1; i++)
    {
        TracingPoint * tp = [[TracingPoint alloc] init];
        tp.coordinate = coords[i];
        tp.course = [Util calculateCourseFromCoordinate:coords[i] to:coords[i+1]];
        [_tracking addObject:tp];
    }
    
    TracingPoint * tp = [[TracingPoint alloc] init];
    tp.coordinate = coords[count - 1];
    tp.course = ((TracingPoint *)[_tracking lastObject]).course;
    [_tracking addObject:tp];
}
- (void)initTrackingWithCoords1:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
{
    _tracking1 = [NSMutableArray array];
    for (int i = 0; i<count - 1; i++)
    {
        TracingPoint * tp = [[TracingPoint alloc] init];
        tp.coordinate = coords[i];
        tp.course = [Util calculateCourseFromCoordinate:coords[i] to:coords[i+1]];
        [_tracking1 addObject:tp];
    }
    
    TracingPoint * tp = [[TracingPoint alloc] init];
    tp.coordinate = coords[count - 1];
    tp.course = ((TracingPoint *)[_tracking lastObject]).course;
    [_tracking1 addObject:tp];
}
- (void)initTrackingWithCoords2:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
{
    _tracking2 = [NSMutableArray array];
    for (int i = 0; i<count - 1; i++)
    {
        TracingPoint * tp = [[TracingPoint alloc] init];
        tp.coordinate = coords[i];
        tp.course = [Util calculateCourseFromCoordinate:coords[i] to:coords[i+1]];
        [_tracking2 addObject:tp];
    }
    
    TracingPoint * tp = [[TracingPoint alloc] init];
    tp.coordinate = coords[count - 1];
    tp.course = ((TracingPoint *)[_tracking lastObject]).course;
    [_tracking2 addObject:tp];
}

#pragma mark - Action

- (void)speedUp
{
    _duration -= 2.5;
    _duration1 -= 2.5;
    _duration2 -= 2.5;

    int speed = ((_durationBaseForSpeed - _duration)/_durationBaseForSpeed * 100);
    NSString* speedStr = [NSString stringWithFormat:@"基速"];
    if (speed > 0 )
    {
        speedStr = [NSString stringWithFormat:@"+%d", speed];
    }
    else if (speed < 0)
    {
        speedStr = [NSString stringWithFormat:@"%d", speed];
    }
    _speedLabel.text = speedStr;
}

- (void)speedDown
{
    _duration += 2.5;
    _duration1 += 2.5;
    _duration2 += 2.5;

    int speed =  ((_durationBaseForSpeed - _duration)/_durationBaseForSpeed * 100);
    NSString* speedStr = [NSString stringWithFormat:@"基速"];
    if (speed > 0 )
    {
        speedStr = [NSString stringWithFormat:@"+%d", speed];
    }
    else if (speed < 0)
    {
        speedStr = [NSString stringWithFormat:@"%d", speed];
    }
    _speedLabel.text = speedStr;
}

- (void) addCar
{
    carCount += 3;
    carCount1 += 3;
    carCount2 += 3;
    [self initAnnotation];
}

- (void) reduceCar
{
    if (carCount - 3 >= 0)
    {
        carCount -= 3;
    }
    if (carCount1 - 3 >= 0)
    {
        carCount1 -= 3;
    }
    if (carCount2 - 3 >= 0)
    {
        carCount2 -= 3;
    }
    [self initAnnotation];
}

- (void)go
{
    /* Step 3. */
    
    /* Find annotation view for car annotation. */
#if 0
    MovingAnnotationView * carView = (MovingAnnotationView *)[self.map viewForAnnotation:self.car];
#endif
    /*
     Add multi points animation to annotation view.
     The coordinate of car annotation will be updated to the last coords after animation is over.
     */
    for (int i = 0; i < carCount; i++)
    {
        MovingAnnotationView* carView = (MovingAnnotationView*) [self.map viewForAnnotation:[annotationArray objectAtIndex:i]];

        NSMutableArray* destArray = [[NSMutableArray alloc] initWithArray:_tracking];
        for (int j = 0; j <= i; j++)
        {
            TracingPoint * tp = destArray[0];
            [destArray removeObjectAtIndex:0];
            [destArray addObject:tp];
        }

        [carView addTrackingAnimationForPoints:destArray duration:_duration];
    }
    for (int i = 0; i < carCount1; i++)
    {
        MovingAnnotationView* carView = (MovingAnnotationView*) [self.map viewForAnnotation:[annotationArray1 objectAtIndex:i]];
        
        NSMutableArray* destArray = [[NSMutableArray alloc] initWithArray:_tracking1];
        for (int j = 0; j <= i; j++)
        {
            TracingPoint * tp = destArray[0];
            [destArray removeObjectAtIndex:0];
            [destArray addObject:tp];
        }
        
        [carView addTrackingAnimationForPoints:destArray duration:_duration1];
    }

    for (int i = 0; i < carCount2; i++)
    {
        MovingAnnotationView* carView = (MovingAnnotationView*) [self.map viewForAnnotation:[annotationArray2 objectAtIndex:i]];
        
        NSMutableArray* destArray = [[NSMutableArray alloc] initWithArray:_tracking2];
        for (int j = 0; j <= i; j++)
        {
            TracingPoint * tp = destArray[0];
            [destArray removeObjectAtIndex:0];
            [destArray addObject:tp];
        }
        
        [carView addTrackingAnimationForPoints:destArray duration:_duration2];
    }

}

- (void)initBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake((self.view.frame.size.width - 60)/2, self.view.frame.size.height * 0.9+30, 60, 20);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"Go" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];

    UIButton * btnAddCar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAddCar.frame = CGRectMake(0, self.view.frame.size.height * 0.9, 60, 20);
    btnAddCar.backgroundColor = [UIColor grayColor];
    [btnAddCar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnAddCar setTitle:@"car+" forState:UIControlStateNormal];
    [btnAddCar addTarget:self action:@selector(addCar) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnAddCar];

    UIButton * btnReduceCar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnReduceCar.frame = CGRectMake(0, self.view.frame.size.height * 0.9 + 30, 60, 20);
    btnReduceCar.backgroundColor = [UIColor grayColor];
    [btnReduceCar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnReduceCar setTitle:@"car-" forState:UIControlStateNormal];
    [btnReduceCar addTarget:self action:@selector(reduceCar) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btnReduceCar];

    UIButton * btnUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnUp.frame = CGRectMake(self.view.frame.size.width-60, self.view.frame.size.height * 0.9, 60, 20);
    btnUp.backgroundColor = [UIColor grayColor];
    [btnUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnUp setTitle:@"speed+" forState:UIControlStateNormal];
    [btnUp addTarget:self action:@selector(speedUp) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btnUp];

    UIButton * btnDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnDown.frame = CGRectMake(self.view.frame.size.width-60, self.view.frame.size.height * 0.9+30, 60, 20);
    btnDown.backgroundColor = [UIColor grayColor];
    [btnDown setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDown setTitle:@"speed-" forState:UIControlStateNormal];
    [btnDown addTarget:self action:@selector(speedDown) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnDown];
}

- (BOOL) inHotArea:(double) lat longitude:(double)lon
{
    CLLocationCoordinate2D topLeft = CLLocationCoordinate2DMake(39.93586, 116.385791);
    CLLocationCoordinate2D bottomRigth = CLLocationCoordinate2DMake(39.935564,   116.386414);

//    if (lat >= bottomRigth.latitude && lat <= topLeft.latitude && lon >= topLeft.longitude && lon <= bottomRigth.longitude)
//    {
//        return YES;
//    }
    return NO;
}

#pragma mark - Map Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* Step 2. */
    if (annotation == self.car)
    {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MovingAnnotationView *annotationView = (MovingAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MovingAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:pointReuseIndetifier];
        }
        
        if ([annotation.title isEqualToString:@"Car"])
        {
            if ( [self inHotArea:[annotation coordinate].latitude longitude:[annotation coordinate].longitude])
            {
                UIImage *imge  =  [UIImage imageNamed:@"hotPoint"];
                annotationView.image =  imge;
                CGPoint centerPoint=CGPointZero;
                [annotationView setCenterOffset:centerPoint];
            }
            else
            {
                UIImage *imge  =  [UIImage imageNamed:@"userPosition"];
                annotationView.image =  imge;
                CGPoint centerPoint=CGPointZero;
                [annotationView setCenterOffset:centerPoint];
            }
        }
        else if ([annotation.title isEqualToString:@"route"])
        {
            annotationView.image = [UIImage imageNamed:@"trackingPoints.png"];
        }

        return annotationView;
    }
    }
    else if (annotation == self.car1)
    {
        if ([annotation isKindOfClass:[MAPointAnnotation class]])
        {
            static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
            MovingAnnotationView *annotationView = (MovingAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[MovingAnnotationView alloc] initWithAnnotation:annotation
                                                                  reuseIdentifier:pointReuseIndetifier];
            }
            
            if ([annotation.title isEqualToString:@"Car"])
            {
                if ( [self inHotArea:[annotation coordinate].latitude longitude:[annotation coordinate].longitude])
                {
                    UIImage *imge  =  [UIImage imageNamed:@"hotPoint"];
                    annotationView.image =  imge;
                    CGPoint centerPoint=CGPointZero;
                    [annotationView setCenterOffset:centerPoint];
                }
                else
                {
                    UIImage *imge  =  [UIImage imageNamed:@"userPositionBlue"];
                    annotationView.image =  imge;
                    CGPoint centerPoint=CGPointZero;
                    [annotationView setCenterOffset:centerPoint];
                }
            }
            else if ([annotation.title isEqualToString:@"route"])
            {
                annotationView.image = [UIImage imageNamed:@"trackingPoints.png"];
            }
            
            return annotationView;
        }
    }
    else if (annotation == self.car2)
    {
        if ([annotation isKindOfClass:[MAPointAnnotation class]])
        {
            static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
            MovingAnnotationView *annotationView = (MovingAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[MovingAnnotationView alloc] initWithAnnotation:annotation
                                                                  reuseIdentifier:pointReuseIndetifier];
            }
            
            if ([annotation.title isEqualToString:@"Car"])
            {
                if ( [self inHotArea:[annotation coordinate].latitude longitude:[annotation coordinate].longitude])
                {
                    UIImage *imge  =  [UIImage imageNamed:@"hotPoint"];
                    annotationView.image =  imge;
                    CGPoint centerPoint=CGPointZero;
                    [annotationView setCenterOffset:centerPoint];
                }
                else
                {
                    UIImage *imge  =  [UIImage imageNamed:@"userPositionYellow"];
                    annotationView.image =  imge;
                    CGPoint centerPoint=CGPointZero;
                    [annotationView setCenterOffset:centerPoint];
                }
            }
            else if ([annotation.title isEqualToString:@"route"])
            {
                annotationView.image = [UIImage imageNamed:@"trackingPoints.png"];
            }
            
            return annotationView;
        }
    }
    
    return nil;
}

- (MAPolylineView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 3.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0.47 blue:1.0 alpha:0.9];
        
        return polylineView;
    }
    
    return nil;
}

#pragma mark - Initialization

- (void)initAnnotation
{
//    [self initRoute];
    
    /* Step 1. */
    //show car
    [self.map removeAnnotations:annotationArray];
    [annotationArray removeAllObjects];
    for (int i = 0; i < carCount; i++)
    {
        int index = i;
        self.car = [[MAPointAnnotation alloc] init];
        if (index >= _tracking.count)
        {
            index -= _tracking.count;
        }
        TracingPoint * start = [_tracking objectAtIndex:index];
        self.car.coordinate = start.coordinate;
        self.car.title = @"Car";
        [self.map addAnnotation:self.car];
        [annotationArray addObject:self.car];
    }
    
    [self.map removeAnnotations:annotationArray1];
    [annotationArray1 removeAllObjects];
    for (int i = 0; i < carCount1; i++)
    {
        int index = i;
        self.car1 = [[MAPointAnnotation alloc] init];
        if (index >= _tracking1.count)
        {
            index -= _tracking1.count;
        }
        TracingPoint * start = [_tracking1 objectAtIndex:index];
        self.car1.coordinate = start.coordinate;
        self.car1.title = @"Car";
        [self.map addAnnotation:self.car1];
        [annotationArray1 addObject:self.car1];
    }

    [self.map removeAnnotations:annotationArray2];
    [annotationArray2 removeAllObjects];
    for (int i = 0; i < carCount2; i++)
    {
        int index = i;
        self.car2 = [[MAPointAnnotation alloc] init];
        if (index >= _tracking2.count)
        {
            index -= _tracking2.count;
        }
        TracingPoint * start = [_tracking2 objectAtIndex:index];
        self.car2.coordinate = start.coordinate;
        self.car2.title = @"Car";
        [self.map addAnnotation:self.car2];
        [annotationArray2 addObject:self.car2];
    }

}

- (MAMapView *)map
{
    if (!_map)
    {
        _map = [[MAMapView alloc] initWithFrame:self.view.frame];
        [_map setDelegate:self];
        
        //加入annotation旋转动画后，暂未考虑地图旋转的情况。
        _map.rotateCameraEnabled = NO;
        _map.rotateEnabled = NO;
    }
    return _map;
}

#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.map];
    _speedLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 40)/2, self.view.frame.size.height * 0.9, 40,20)];
    [_speedLabel setText:@"基速"];
    _speedLabel.textColor = [UIColor redColor];
//    [_speedLabel setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_speedLabel];

    [self initBtn];
    [self initRoute];
    [self initAnnotation];
}


@end
