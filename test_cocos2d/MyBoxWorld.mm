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
    CGSize winSize = [CCDirector sharedDirector].winSize;
    b2Vec2 gravity = b2Vec2(0.0f,-2.0f);
    _world = new b2World(gravity);
    
    //create edges around the entire screen
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0, 0);
    _groundBody = _world->CreateBody(&groundBodyDef);
    b2EdgeShape groundEdge;
    b2FixtureDef boxShapeDef;
    boxShapeDef.shape = &groundEdge;
    groundEdge.Set(b2Vec2(0,0), b2Vec2(winSize.width/PTM_RATIO,0));
    _groundBody->CreateFixture(&boxShapeDef);
    groundEdge.Set(b2Vec2(0, 0), b2Vec2(0, winSize.height/PTM_RATIO));
    _groundBody->CreateFixture(&boxShapeDef);
    groundEdge.Set(b2Vec2(0, winSize.height/PTM_RATIO), b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO));
    _groundBody->CreateFixture(&boxShapeDef);
    groundEdge.Set(b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO), b2Vec2(winSize.width/PTM_RATIO,0));
    _groundBody->CreateFixture(&boxShapeDef);
}

- (void)tick:(ccTime)dt
{
    _world->Step(dt, 10, 10);
    for(b2Body *b = _world->GetBodyList();b;b=b->GetNext())
    {
        if(b->GetUserData()!=NULL)
        {
            CCSprite *sprite = (CCSprite*)b->GetUserData();
            
            if(sprite.tag == BALL)
            {
                static int maxSpeed = 10;
                b2Vec2 velocity = b->GetLinearVelocity();
                float speed = velocity.Length();
                
                if(speed>maxSpeed)
                {
                    b->SetLinearDamping(0.5);
                }else if(speed<maxSpeed)
                {
                    b->SetLinearDamping(0.0);
                }
            }
            
            sprite.position = ccp(b->GetPosition().x*PTM_RATIO, b->   GetPosition().y*PTM_RATIO);
            sprite.rotation = -1*CC_RADIANS_TO_DEGREES(b->GetAngle());
        }
    }
}


- (void)addABall
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
    ballShapeDef.friction = 0.0f;
    ballShapeDef.restitution = 1.0f;
    body->CreateFixture(&ballShapeDef);
    
    [self schedule:@selector(tick:)];
}

- (void)addPaddle
{
    CCSprite *paddle = [CCSprite spriteWithFile:@"Paddle.jpg"];
    paddle.position = ccp(200, paddle.contentSize.height/2);
    [self addChild:paddle z:1 tag:PADDLE];
    
    b2BodyDef paddleBodyDef;
    paddleBodyDef.type = b2_dynamicBody;
    paddleBodyDef.position.Set(200/PTM_RATIO, paddle.contentSize.height/2/PTM_RATIO);
    paddleBodyDef.userData = paddle;
    _paddleBody = _world->CreateBody(&paddleBodyDef);
    
    b2PolygonShape polygon;
    polygon.SetAsBox(paddle.contentSize.width/2/PTM_RATIO, paddle.contentSize.height/2/PTM_RATIO);
    
    b2FixtureDef paddleShapeDef;
    paddleShapeDef.shape = &polygon;
    paddleShapeDef.density = 1.0f;
    paddleShapeDef.friction = 0.0f;
    paddleShapeDef.restitution = 1.0f;
    _paddleFixture = _paddleBody->CreateFixture(&paddleShapeDef);
    
    b2PrismaticJointDef jointDef;
    b2Vec2 worldAxis(1.0f,0.0f);
    jointDef.collideConnected = true;
    jointDef.Initialize(_paddleBody, _groundBody, _paddleBody->GetWorldCenter(), worldAxis);
    _world->CreateJoint(&jointDef);
    
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self initWorld];
        [self addABall];
        [self addPaddle];
        
        
        self.isTouchEnabled = YES;
    }
    return self;
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_mouseJoint)
    _world->DestroyJoint(_mouseJoint);
    _mouseJoint = NULL;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    point = [[CCDirector sharedDirector] convertToGL:point];
    b2Vec2 locationInWorld = b2Vec2(point.x/PTM_RATIO,point.y/PTM_RATIO);
    if(_paddleFixture->TestPoint(locationInWorld))
    {
        b2MouseJointDef md;
        md.bodyA = _groundBody;
        md.bodyB = _paddleBody;
        md.target = locationInWorld;
        md.collideConnected = true;
        md.maxForce = 1000.f * _paddleBody->GetMass();
        
        _mouseJoint = (b2MouseJoint*)_world->CreateJoint(&md);
        _paddleBody->SetAwake(true);
        
        
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!_mouseJoint)
        return;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    point = [[CCDirector sharedDirector] convertToGL:point];
    b2Vec2 locationInWorld = b2Vec2(point.x/PTM_RATIO,point.y/PTM_RATIO);
    _mouseJoint->SetTarget(locationInWorld);

   
    
}





@end
