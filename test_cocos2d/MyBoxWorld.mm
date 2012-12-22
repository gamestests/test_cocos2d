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
    _world->SetAllowSleeping(true);
    
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
    
    CCSprite *backGround = [CCSprite spriteWithFile:@"back1.png"];
    backGround.position = ccp(50, 50);
    [self addChild:backGround];
    
   
  

    
    
    
    
    
    b2BodyDef bodyDef;
    bodyDef.position.Set(50/PTM_RATIO,50/PTM_RATIO);
    bodyDef.userData = backGround;
    
    b2PolygonShape boxDef;
    //row 1, col 1
    int num1 = 6;
    b2Vec2 verts1[] = {
        b2Vec2(-6.5f / PTM_RATIO, -17.3f / PTM_RATIO),
        b2Vec2(-2.3f / PTM_RATIO, -10.0f / PTM_RATIO),
        b2Vec2(-3.0f / PTM_RATIO, 2.4f / PTM_RATIO),
        b2Vec2(-17.6f / PTM_RATIO, 13.3f / PTM_RATIO),
        b2Vec2(-41.5f / PTM_RATIO, 15.5f / PTM_RATIO),
        b2Vec2(-48.5f / PTM_RATIO, 8.2f / PTM_RATIO)    };

    boxDef.Set(verts1, num1);
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &boxDef;
    fixtureDef.density = 0.0f;
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 1.0f;
    
    b2Body *body = _world->CreateBody(&bodyDef);
    body->CreateFixture(&fixtureDef);
    
    
    
    
    int num2 = 3;
    b2Vec2 verts2[] = {
        b2Vec2(-48.7f / PTM_RATIO, -48.2f / PTM_RATIO),
        b2Vec2(48.3f / PTM_RATIO, -48.9f / PTM_RATIO),
        b2Vec2(-48.1f / PTM_RATIO, 8.0f / PTM_RATIO)
    };
    
    boxDef.Set(verts2, num2);
    body->CreateFixture(&fixtureDef);
    
    int num3 = 4;
    b2Vec2 verts3[] = {
        b2Vec2(34.1f / PTM_RATIO, -39.9f / PTM_RATIO),
        b2Vec2(34.8f / PTM_RATIO, -30.3f / PTM_RATIO),
        b2Vec2(24.6f / PTM_RATIO, -22.3f / PTM_RATIO),
        b2Vec2(4.0f / PTM_RATIO, -22.6f / PTM_RATIO)
    };
    boxDef.Set(verts3, num3);
    body->CreateFixture(&fixtureDef);
    
    
    
    
    
    
    
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


- (void)addALine
{
    
    b2Vec2 verts[] = {
        b2Vec2(41.8f / PTM_RATIO, 67.6f / PTM_RATIO),
        b2Vec2(73.9f / PTM_RATIO, 77.3f / PTM_RATIO),
        b2Vec2(86.7f / PTM_RATIO, 64.6f / PTM_RATIO),
        b2Vec2(97.4f / PTM_RATIO, 56.6f / PTM_RATIO),
        b2Vec2(111.1f / PTM_RATIO, 58.2f / PTM_RATIO),
        b2Vec2(124.8f / PTM_RATIO, 62.3f / PTM_RATIO),
        b2Vec2(147.2f / PTM_RATIO, 65.3f / PTM_RATIO),
        b2Vec2(158.5f / PTM_RATIO, 59.9f / PTM_RATIO),
        b2Vec2(158.5f / PTM_RATIO, 49.2f / PTM_RATIO),
        b2Vec2(163.2f / PTM_RATIO, 40.5f / PTM_RATIO),
        b2Vec2(182.0f / PTM_RATIO, 37.5f / PTM_RATIO),
        b2Vec2(197.3f / PTM_RATIO, 39.2f / PTM_RATIO),
        b2Vec2(209.1f / PTM_RATIO, 46.2f / PTM_RATIO),
        b2Vec2(217.1f / PTM_RATIO, 57.9f / PTM_RATIO),
        b2Vec2(224.7f / PTM_RATIO, 64.6f / PTM_RATIO)
    };

    
    b2ChainShape chain;
    chain.CreateChain(verts, 15);
    b2FixtureDef lineDef;
    lineDef.shape = &chain;
    
    b2BodyDef bodyDef;
    bodyDef.position.Set(100/PTM_RATIO,100/PTM_RATIO);
    b2Body *body = _world->CreateBody(&bodyDef);
    
    body->CreateFixture(&lineDef);
    
    
    
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self initWorld];
        [self addABall];
        [self addPaddle];
        [self addALine];
        
        
        
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
