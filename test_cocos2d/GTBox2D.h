//
//  GTBox2D.h
//  test_cocos2d
//
//  Created by gxs on 12-12-23.
//
//

#import <Foundation/Foundation.h>

#import "ContentSupport.h"
#import "Box2D.h"

@interface GTBox2D : NSObject
{
    b2World *_world;
}

@property (readonly) b2World *world;


+ (GTBox2D*)sharedGTBox2D;

@end
