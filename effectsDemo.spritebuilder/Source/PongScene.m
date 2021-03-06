//
//  PongScene.m
//  effectsDemo
//
//  Created by Oleg Osin on 5/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PongScene.h"
#import "CCDirector.h"
#import  "CCEffectNode.h"

#define PADDLE_HEIGHT 100.0f
#define PADDLE_WIDTH 30.0f

#define BALL_HEIGHT 10.0f
#define BALL_WIDTH 10.0f


@implementation PongScene {
    CCNodeColor* _leftPaddle;
    CCNodeColor* _rightPaddle;
    CCNodeColor* _ball;
    CGSize _designSize;
    
}

- (float)centerPaddleY:(float)y
{
    float centerY = y - PADDLE_HEIGHT * 0.5f;
    return centerY;
}

- (void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;

    CCPhysicsNode *physics = [CCPhysicsNode node];
	physics.debugDraw = YES;
	[self addChild:physics];
    
    _designSize = [[CCDirector sharedDirector] designSize];
    
    // Left paddle (player)
    _leftPaddle = [CCNodeColor nodeWithColor:[CCColor redColor]];
    _leftPaddle.anchorPoint = ccp(0.0, 0.0);
    _leftPaddle.contentSize = CGSizeMake(PADDLE_WIDTH, PADDLE_HEIGHT);
    _leftPaddle.position = ccp(0.0, [self centerPaddleY:_designSize.height * 0.5f]);
    
    CGRect rect = {CGPointZero, _leftPaddle.contentSize};
    CCPhysicsBody *body = _leftPaddle.physicsBody = [CCPhysicsBody bodyWithRect:rect cornerRadius:0.0];
    body.type = CCPhysicsBodyTypeStatic;
    [physics addChild:_leftPaddle];
    //[self addChild:_leftPaddle];
    
    // Right paddle (AI)
    _rightPaddle = [CCNodeColor nodeWithColor:[CCColor redColor]];
    _rightPaddle.anchorPoint = ccp(0.0, 0.0);
    _rightPaddle.contentSize = CGSizeMake(PADDLE_WIDTH, PADDLE_HEIGHT);
    _rightPaddle.position = ccp(_designSize.width - PADDLE_WIDTH, [self centerPaddleY:_designSize.height * 0.5f]);
    
    rect.size = _rightPaddle.contentSize;
    body = _rightPaddle.physicsBody = [CCPhysicsBody bodyWithRect:rect cornerRadius:0.0];
    body.type = CCPhysicsBodyTypeStatic;
    [physics addChild:_rightPaddle];
    //[self addChild:_rightPaddle];

    // Ball
    _ball = [CCNodeColor nodeWithColor:[CCColor greenColor]];
    _ball.anchorPoint = ccp(0.5, 0.5);
    _ball.contentSize = CGSizeMake(BALL_WIDTH, BALL_HEIGHT);
    _ball.position = ccp(_designSize.width * 0.5f, _designSize.height * 0.5f);
    
    rect.size = _ball.contentSize;
    body = _ball.physicsBody = [CCPhysicsBody bodyWithRect:rect cornerRadius:0.0];
    body.velocity = ccp(-30, 0);
    body.angularVelocity = 0.1;
    [physics addChild:_ball];
    //[self addChild:_ball];
    
    [self schedule:@selector(sceneUpdate:) interval:1.0f/60.0f];
}

- (void)sceneUpdate:(CCTime)interval
{
    
}

#pragma mark touch

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    // pseudo
    /*
     CGPoint location = [touch locationInNode:node];
     CGRect box = node.sprite.boundingBox;
     
     if(CGRectContainsPoint(box, location))
     {
     
     }
     */
    
    CGPoint location = [touch locationInNode:self];
    if(location.x < _designSize.width * 0.5f)
    {
        _leftPaddle.position = ccp(_leftPaddle.position.x, [self centerPaddleY:location.y]);
    }
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInNode:self];
    if(location.x < _designSize.width * 0.5f)
    {
        _leftPaddle.position = ccp(_leftPaddle.position.x, [self centerPaddleY:location.y]);
    }
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

@end
