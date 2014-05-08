//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "CCDirector.h"

@implementation MainScene


#define ENABLE_BLOOM

- (void) didLoadFromCCB
{
    // Ground (no bloom)
    CCSprite* ground = [CCSprite spriteWithImageNamed:@"ccbResources/lens_grass_2.png"];
    ground.anchorPoint = ccp(0.0, 0.0);
    ground.position = ccp(-0.05, -0.1);
    ground.scale = 2.0f;
    ground.positionType = CCPositionTypeNormalized;
    
    CCSprite* ground2 = [CCSprite spriteWithImageNamed:@"ccbResources/lens_grass_2.png"];
    ground2.anchorPoint = ccp(0.0, 0.0);
    ground2.position = ccp(0.25, -0.1);
    ground2.scale = 2.0f;
    ground2.positionType = CCPositionTypeNormalized;

    CCSprite* ground3 = [CCSprite spriteWithImageNamed:@"ccbResources/lens_grass_2.png"];
    ground3.anchorPoint = ccp(0.0, 0.0);
    ground3.position = ccp(0.5, -0.1);
    ground3.scale = 2.0f;
    ground3.positionType = CCPositionTypeNormalized;

    [self addChild:ground];
    [self addChild:ground2];
    [self addChild:ground3];
    
    // Foliage (ground)
    CCSprite* tree = [CCSprite spriteWithImageNamed:@"ccbResources/tree_acacia_2.png"];
    tree.anchorPoint = ccp(0.0, 0.0);
    tree.position = ccp(0.0, 0.0);
    tree.positionType = CCPositionTypeNormalized;

    CCSprite* bush = [CCSprite spriteWithImageNamed:@"ccbResources/heights_bush_1.png"];
    bush.anchorPoint = ccp(0.0, 0.0);
    bush.position = ccp(0.2, 0.0);
    bush.positionType = CCPositionTypeNormalized;

    CCSprite* bush2 = [CCSprite spriteWithImageNamed:@"ccbResources/heights_bush_1.png"];
    bush2.anchorPoint = ccp(0.0, 0.0);
    bush2.position = ccp(0.3, 0.0);
    bush2.positionType = CCPositionTypeNormalized;
    
    CCSprite* tree2 = [CCSprite spriteWithImageNamed:@"ccbResources/tree_acacia_4.png"];
    tree2.anchorPoint = ccp(0.0, 0.0);
    tree2.position = ccp(0.29, 0.0);
    tree2.positionType = CCPositionTypeNormalized;
    
    CCSprite* grass = [CCSprite spriteWithImageNamed:@"ccbResources/pampas_2.png"];
    grass.anchorPoint = ccp(0.0, 0.0);
    grass.position = ccp(0.48, 0.0);
    grass.positionType = CCPositionTypeNormalized;
    
    CCSprite* tree3 = [CCSprite spriteWithImageNamed:@"ccbResources/tree_acacia_3.png"];
    tree3.anchorPoint = ccp(0.0, 0.0);
    tree3.position = ccp(0.48, 0.0);
    tree3.positionType = CCPositionTypeNormalized;

    CCSprite* grass2 = [CCSprite spriteWithImageNamed:@"ccbResources/pampas_1.png"];
    grass2.anchorPoint = ccp(0.0, 0.0);
    grass2.position = ccp(0.8, 0.0);
    grass2.positionType = CCPositionTypeNormalized;
    
    CCSprite* bush3 = [CCSprite spriteWithImageNamed:@"ccbResources/heights_bush_1.png"];
    bush3.anchorPoint = ccp(0.0, 0.0);
    bush3.position = ccp(0.66, 0.0);
    bush3.positionType = CCPositionTypeNormalized;
    
    // sky
    
    CCSprite* dirtPlatform = [CCSprite spriteWithImageNamed:@"ccbResources/floating_platform_dirt_03.png"];
    dirtPlatform.anchorPoint = ccp(0.0, 0.0);
    dirtPlatform.position = ccp(0.1, 0.7);
    dirtPlatform.positionType = CCPositionTypeNormalized;

    CCSprite* stalagmite = [CCSprite spriteWithImageNamed:@"ccbResources/stalagmite_1.png"];
    stalagmite.anchorPoint = ccp(0.0, 0.0);
    stalagmite.position = ccp(0.25, 0.53);
    stalagmite.positionType = CCPositionTypeNormalized;
    stalagmite.scale = 0.5;
    [dirtPlatform addChild:stalagmite];
    
    CCSprite* grassPlatform = [CCSprite spriteWithImageNamed:@"ccbResources/floating_platform_grass_02.png"];
    grassPlatform.anchorPoint = ccp(0.0, 0.0);
    grassPlatform.position = ccp(0.4, 0.4);
    grassPlatform.positionType = CCPositionTypeNormalized;

    CCSprite* treeBase = [CCSprite spriteWithImageNamed:@"ccbResources/bling_tree_base_moss_1.png"];
    treeBase.anchorPoint = ccp(0.0, 0.0);
    treeBase.position = ccp(0.15, 0.59);
    treeBase.positionType = CCPositionTypeNormalized;
    treeBase.scale = 0.7f;
    [grassPlatform addChild:treeBase];
    
    CCSprite* grassPlatform2 = [CCSprite spriteWithImageNamed:@"ccbResources/floating_platform_grass_02.png"];
    grassPlatform2.anchorPoint = ccp(0.0, 0.0);
    grassPlatform2.position = ccp(0.8, 0.5);
    grassPlatform2.positionType = CCPositionTypeNormalized;

    CCSprite* jellyTree = [CCSprite spriteWithImageNamed:@"ccbResources/bling_jellytree_1.png"];
    jellyTree.anchorPoint = ccp(0.0, 0.0);
    jellyTree.position = ccp(0.2, 0.6);
    jellyTree.positionType = CCPositionTypeNormalized;
    [grassPlatform2 addChild:jellyTree];

    CCSprite* rainbow = [CCSprite spriteWithImageNamed:@"ccbResources/rainbow.png"];
    rainbow.anchorPoint = ccp(0.0, 0.0);
    rainbow.position = ccp(-0.05, 0.1);
    rainbow.scale = 6.0;
    rainbow.positionType = CCPositionTypeNormalized;


#ifdef ENABLE_BLOOM
    CGSize size = [[CCDirector sharedDirector] designSize];
    // Blend glow maps test
    CCEffectNode* glowEffectNode = [[CCEffectNode alloc] initWithWidth:size.width height:size.height];
    [glowEffectNode addChild:tree];
    [glowEffectNode addChild:bush];
    [glowEffectNode addChild:bush2];
    [glowEffectNode addChild:tree2];
    [glowEffectNode addChild:grass];
    [glowEffectNode addChild:tree3];
    [glowEffectNode addChild:grass2];
    [glowEffectNode addChild:bush3];
    
    // sky
    [glowEffectNode addChild:dirtPlatform];
    [glowEffectNode addChild:grassPlatform];
    [glowEffectNode addChild:grassPlatform2];
    [glowEffectNode addChild:rainbow];
    
    CCEffectGlow* glowEffect = [CCEffectGlow effectWithRadius:0.002f];
    glowEffectNode.effect = glowEffect;

    [self addChild:glowEffectNode];
#else
    [self addChild:tree];
    [self addChild:bush];
    [self addChild:bush2];
    [self addChild:tree2];
    [self addChild:grass];
    [self addChild:tree3];
    [self addChild:grass2];
    [self addChild:bush3];
    
    // sky
    [self addChild:dirtPlatform];
    [self addChild:grassPlatform];
    [self addChild:grassPlatform2];
    [self addChild:rainbow];
#endif
}


@end
