//
//  GameScene.h
//  test_cocos2d
//
//  Created by gxs on 12-12-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Player.h"

@interface GameScene : CCLayer {
    
    Player *_player;
    
}


+ (CCScene*)scene;


@end
