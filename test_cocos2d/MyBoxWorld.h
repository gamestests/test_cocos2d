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
//    
//    b2World *_world;
//    
    b2EdgeShape _groundEdge;
    b2Body *_groundBody;
    b2Body *_paddleBody;
    b2MouseJoint *_mouseJoint;
    
    b2Fixture *_paddleFixture;
    
    b2Fixture *_lineFixture;
    
    CGPoint _beginPoint;
    CGPoint _movePoint;
    BOOL _isPaddleAction;
    
    NSMutableArray *_linePoint;
    NSMutableArray *_lines;
    
}


+ (CCScene*)scene;


@end
