//
//  MyBoxWorld.m
//  test_cocos2d
//
//  Created by gxs on 12-12-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyBoxWorld.h"

#define PTM_RATIO 32

@implementation MyBoxWorld

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    MyBoxWorld *layer = [MyBoxWorld node];
    [scene addChild:layer];
    return scene;
}

- (void)initWorld
{
    b2Vec2 gravity = b2Vec2(0.0f,-2.0f);
    _world = new b2World(gravity);
}

- (void)tick:(ccTime)dt
{
    _world->Step(dt, 10, 10);
    for(b2Body *b = _world->GetBodyList();b;b=b->GetNext())
    {
        if(b->GetUserData()!=NULL)
        {
            CCSprite *ballData = (CCSprite*)b->GetUserData();
            ballData.position = ccp(b->GetPosition().x*PTM_RATIO, b->GetPosition().y*PTM_RATIO);
            ballData.rotation = -1*CC_RADIANS_TO_DEGREES(b->GetAngle());
        }
    }
}


- (void)addTarget
{
    CCSprite *ball = [CCSprite spriteWithFile:@"Ball.jpg"];
    ball.position = ccp(200, 200);
    [self addChild:ball z:1 tag:BALL];
    
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(200/PTM_RATIO,200/PTM_RATIO);
    ballBodyDef.userData = ball;
    b2Body *body = _world->CreateBody(&ballBodyDef);
    
    b2CircleShape circle;
    circle.m_radius = 26.0/PTM_RATIO;
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.2f;
    ballShapeDef.restitution = 0.8f;
    body->CreateFixture(&ballShapeDef);
    
    [self schedule:@selector(tick:)];
    
    
    
    
    
}


- (id)init
{
    self = [super init];
    if (self) {
        
        [self initWorld];
        [self addTarget];
        
        
        
    }
    return self;
}










@end
