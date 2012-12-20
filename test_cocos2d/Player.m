//
//  Player.m
//  test_cocos2d
//
//  Created by gxs on 12-12-18.
//
//

#import "Player.h"




@implementation Player

- (void)addAnimation
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"player.plist"];
    
    
    _arrAnimate = [[NSMutableArray alloc] init];
    NSMutableArray *frams = [NSMutableArray array];
    [frams addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_down.png"]];
    [frams addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_goDown_0.png"]];
    [frams addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_goDown_1.png"]];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frams delay:0.08f];
    CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
    CCRepeatForever *forever = [CCRepeatForever actionWithAction:animate];
    
    NSMutableArray *frams1 = [NSMutableArray array];
    [frams1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_up.png"]];
    [frams1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_goUp_0.png"]];
    [frams1 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_goUp_1.png"]];
    CCAnimation *animation1 = [CCAnimation animationWithSpriteFrames:frams1 delay:0.08f];
    CCAnimate *animate1 = [CCAnimate actionWithAnimation:animation1];
    CCRepeatForever *forever1 = [CCRepeatForever actionWithAction:animate1];
    
    NSMutableArray *frams2 = [NSMutableArray array];
    [frams2 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_left.png"]];
    [frams2 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_goLeft_0.png"]];
    [frams2 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_goLeft_1.png"]];
    CCAnimation *animation2 = [CCAnimation animationWithSpriteFrames:frams2 delay:0.08f];
    CCAnimate *animate2 = [CCAnimate actionWithAnimation:animation2];
    CCRepeatForever *forever2 = [CCRepeatForever actionWithAction:animate2];
    
    NSMutableArray *frams3 = [NSMutableArray array];
    [frams3 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_right.png"]];
    [frams3 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_goRight_0.png"]];
    [frams3 addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"player_goRight_1.png"]];
    CCAnimation *animation3 = [CCAnimation animationWithSpriteFrames:frams3 delay:0.08f];
    CCAnimate *animate3 = [CCAnimate actionWithAnimation:animation3];
    CCRepeatForever *forever3 = [CCRepeatForever actionWithAction:animate3];
    
    [_arrAnimate addObject:forever];
    [_arrAnimate addObject:forever1];
    [_arrAnimate addObject:forever2];
    [_arrAnimate addObject:forever3];
    
}

- (id)init
{
    self = [super init];
    if (self) {
        _direction = 0;
        [self addAnimation];
        _sprite = [[CCSprite alloc] initWithSpriteFrameName:@"player_left.png"];
        [_sprite runAction:[_arrAnimate objectAtIndex:0]];
        
    }
    return self;
}


- (void)setDirection:(PLAYER_ANIMATION)direction
{
    [_sprite stopAction:[_arrAnimate objectAtIndex:_direction]];
    _direction = direction;
    [_sprite runAction:[_arrAnimate objectAtIndex:direction]];
    NSLog(@"direction is %d",_direction);
}

- (PLAYER_ANIMATION)direction
{
    return _direction;
}


@end
