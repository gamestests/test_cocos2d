//
//  GTBox2D.m
//  test_cocos2d
//
//  Created by gxs on 12-12-23.
//
//

#import "GTBox2D.h"

static GTBox2D *sharedGTBox2D = nil;

@implementation GTBox2D

@synthesize world = _world;

+ (GTBox2D *)sharedGTBox2D
{
    if(!sharedGTBox2D)
        sharedGTBox2D = [[GTBox2D alloc] init];
    return sharedGTBox2D;
}

- (id)init
{
    self = [super init];
    if (self) {
        b2Vec2 gravity = b2Vec2(GT_BOX2D_GRAVITY_X,GT_BOX2D_GRAVITY_Y);
        _world = new b2World(gravity);
        _world->SetAllowSleeping(true);
    }
    return self;
}

- (void)dealloc
{
    [sharedGTBox2D release];
    sharedGTBox2D = nil;
    [super dealloc];
}



@end
