//
//  Box2DBasicSprite.h
//  test_cocos2d
//
//  Created by gxs on 12-12-23.
//
//

#import "BasicSprite.h"

#import "Box2D.h"

@interface Box2DBasicSprite : BasicSprite
{
    b2BodyDef _bodyDef;
    b2Body *_body;
    b2FixtureDef _bodyFixtureDef;
    b2Fixture *_bodyFixture;
}

@property (readonly, nonatomic) b2Body *body;



//- (void)initWithPosition:(b2Vec2)vec World:(b2World*)world;
- (id)initWithPosition:(CGPoint)position;

@end
