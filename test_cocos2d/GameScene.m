//
//  GameScene.m
//  test_cocos2d
//
//  Created by gxs on 12-12-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"

#import "Player.h"

@implementation GameScene


+(CCScene *)scene
{
    CCScene *scene = [CCScene node];
    GameScene *layer = [GameScene node];
    [scene addChild:layer];
    return scene;
}

- (void)changeDirection
{
    static int i = 1;
    if(i >= 4)
        i = 0;
    _player.direction = i++;
    
}

- (void)handlePan:(UIPanGestureRecognizer*)reconizer
{
    if(reconizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [reconizer translationInView:[reconizer view]];
        point = ccp(point.x, -point.y);
        NSLog(@"move point is (%f,%f)",point.x,point.y);
        self.position = ccpMidpoint(self.position, point);
    }
}

- (void)addGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [[[CCDirector sharedDirector] view] addGestureRecognizer:pan];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        
        _player = [[Player alloc] init];
        _player.position = ccp(100, 100);
        
        [self addChild:_player.sprite z:0 tag:10];
        
        CCSprite *spr1 = [CCSprite spriteWithFile:@"Icon.png"];
        CCSprite *spr2 = [CCSprite spriteWithFile:@"Icon.png"];
        spr2.color = ccRED;
        
        CCMenuItemSprite *item = [CCMenuItemSprite itemWithNormalSprite:spr1 selectedSprite:spr2 target:self selector:@selector(changeDirection)];
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        [self addChild:menu];
        [self addGesture];
        
    }
    return self;
}



@end
