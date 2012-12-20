//
//  Player.h
//  test_cocos2d
//
//  Created by gxs on 12-12-18.
//
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

#import "BasicSprite.h"

typedef enum
{
    RUNDOWN,
    RUNUP,
    RUNLEFT,
    RUNRIGHT,
}PLAYER_ANIMATION;


@interface Player : BasicSprite
{
    NSMutableArray *_arrAnimate;
    PLAYER_ANIMATION _direction;
}

@property (setter = setDirection:,getter = direction,assign, nonatomic) PLAYER_ANIMATION direction;



@end
