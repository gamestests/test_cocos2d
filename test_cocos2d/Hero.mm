//
//  Hero.m
//  test_cocos2d
//
//  Created by gxs on 12-12-23.
//
//

#import "Hero.h"

#import "ContentSupport.h"
#import "GTBox2D.h"

@implementation Hero

- (id)initWithPosition:(CGPoint)position
{
    self = [super init];
    if (self) {
        
        b2World *world = [GTBox2D sharedGTBox2D].world;
        
        _sprite = [[CCSprite alloc] initWithFile:@"maoball.png"];
        _sprite.position = position;
        
        b2CircleShape circle;
        circle.m_radius = 16/PTM_RATIO;
        
        _bodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
        _bodyDef.type = b2_dynamicBody;
        _bodyDef.userData = _sprite;
        _body = world->CreateBody(&_bodyDef);
        
        _bodyFixtureDef.shape = &circle;
        _bodyFixtureDef.density = 1.0f;
        _bodyFixtureDef.friction = 0.0f;
        _bodyFixtureDef.restitution = 1.0f;
        _bodyFixture = _body->CreateFixture(&_bodyFixtureDef);
        
    }
    return self;

}

- (id)init
{
    self = [super init];
    if (self) {
        assert(0);//这个方法不能被调用，请使用 initWithPosition
    }
    return self;
}

- (void)setPosition:(CGPoint)position
{
    [super setPosition:position];
}

@end
