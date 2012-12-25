//
//  GameSceneBox2D.m
//  test_cocos2d
//
//  Created by gxs on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSceneBox2D.h"

#import "GTBox2D.h"

#import "Hero.h"

@implementation GameSceneBox2D

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    GameSceneBox2D *layer = [GameSceneBox2D node];
    [scene addChild:layer];
    return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        b2World *world = [GTBox2D sharedGTBox2D].world;
        
        Hero *hero = [[Hero alloc] initWithPosition:ccp(300, 300)];
        [self addChild:hero.sprite z:0 tag:HERO];
        
        Hero *hero1 = [[Hero alloc] initWithPosition:ccp(280, 280)];
        hero1.body->SetType(b2_staticBody);
        [self addChild:hero1.sprite z:0 tag:10];
        
        b2RopeJointDef jd;
        jd.bodyA = hero.body;
        jd.bodyB = hero1.body;
        
        jd.localAnchorA = b2Vec2(0,0);
        jd.localAnchorB = b2Vec2(0,0);
        
        jd.maxLength = 100/PTM_RATIO;
        world->CreateJoint(&jd);
        
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        [self schedule:@selector(tick:)];
        
        
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        
    }
    return self;
}

- (void)tick:(ccTime)dt
{
    b2World *world = [GTBox2D sharedGTBox2D].world;
    world->Step(dt, 10, 10);
    for(b2Body *b = world->GetBodyList();b;b=b->GetNext())
    {
        if(b->GetUserData()!=NULL)
        {
            CCSprite *sprite = (CCSprite*)b->GetUserData();
            
            if(sprite.tag == HERO)
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



@end
