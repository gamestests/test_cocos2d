//
//  MyBoxWorld.h
//  test_cocos2d
//
//  Created by gxs on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Box2D.h"

typedef enum
{
    BALL,
    PADDLE
}SPRITE;


@interface MyBoxWorld : CCLayer {
    
    b2World *_world;
    
    b2Body *_groundBody;
    b2Body *_paddleBody;
    b2MouseJoint *_mouseJoint;
    
    b2Fixture *_paddleFixture;
    
    CGPoint _beginPoint;
    BOOL _isPaddleAction;
    
}


+ (CCScene*)scene;


@end
