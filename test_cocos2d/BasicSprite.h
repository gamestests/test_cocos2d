//
//  BasicSprite.h
//  test_cocos2d
//
//  Created by gxs on 12-12-18.
//
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"


@interface BasicSprite : NSObject
{
    CCSprite *_sprite;
}

@property (assign, nonatomic) CCSprite *sprite;
@property (setter = setPosition:,getter = position,assign, nonatomic) CGPoint position;




@end
