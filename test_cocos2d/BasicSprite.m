//
//  BasicSprite.m
//  test_cocos2d
//
//  Created by gxs on 12-12-18.
//
//

#import "BasicSprite.h"

@implementation BasicSprite

@synthesize sprite = _sprite;

- (void)setPosition:(CGPoint)position
{
    _sprite.position = position;
}

- (CGPoint)position
{
    return _sprite.position;
}


@end
