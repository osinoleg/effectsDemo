//
//  CCEffectStack.m
//  cocos2d-ios
//
//  Created by Oleg Osin on 4/10/14.
//
//

#import "CCEffectStack.h"
#import "CCEffectStack_Private.h"
#import "CCEffect_Private.h"

#if CC_ENABLE_EXPERIMENTAL_EFFECTS
@implementation CCEffectStack

- (id)init
{
    return [self initWithEffects:nil];
}

- (id)initWithEffects:(NSArray *)effects
{
    if ((self = [super init]))
    {
        if (effects)
        {
            _effects = [effects mutableCopy];
        }
        else
        {
            _effects = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)addEffect:(CCEffect *)effect
{
    [_effects addObject:effect];
}

- (NSUInteger)effectCount
{
    return _effects.count;
}

- (CCEffect *)effectAtIndex:(NSUInteger)effectIndex
{
    NSAssert(effectIndex < _effects.count,@"Pass index out of range.");
    return _effects[effectIndex];
}


#pragma mark - Private

- (BOOL)prepareForRendering
{
    return YES;
}



+(CCEffect*)effects:(id)firstObject, ...
{
    NSMutableArray* effects = [[NSMutableArray alloc] init];
   
    id object;
    va_list argumentList;
    
    va_start(argumentList, firstObject);
    object = firstObject;
    
    while(object != nil)
    {
        [effects addObject:object];
        object = va_arg(argumentList, id);
    }
    
    va_end(argumentList);
    
    NSMutableArray* fragFunctions = [[NSMutableArray alloc] init];
    NSMutableArray* fragUniforms = [[NSMutableArray alloc] init];
    [CCEffectStack extractFragmentData:effects functions:fragFunctions uniforms:fragUniforms];
   
    NSMutableArray* vertexFunctions = [[NSMutableArray alloc] init];
    NSMutableArray* vertexUniforms = [[NSMutableArray alloc] init];
    [CCEffectStack extractVertexData:effects functions:vertexFunctions uniforms:vertexUniforms];
    
    CCEffect* compositeEffect = [[CCEffect alloc] initWithFragmentFunction:fragFunctions vertexFunctions:vertexFunctions fragmentUniforms:fragUniforms vertextUniforms:vertexUniforms varying:nil];
    
    return compositeEffect;
}

+(void)extractFragmentData:(NSMutableArray*)effects functions:(NSMutableArray*)functions uniforms:(NSMutableArray*)uniforms
{
    // Check for duplicate names
    NSMutableDictionary* functionNames = [[NSMutableDictionary alloc] init];

    // Extract all fragment functions and uniforms
    for(CCEffect* effect in effects)
    {
        for(CCEffectFunction* function in effect.fragmentFunctions)
        {
            if([functionNames objectForKey:function.name])
                continue;
            
            [functions addObject:function];
            [functionNames setObject:@YES forKey:function.name];
        }
        
        // TODO: check/handle uniforms with the same name
        [uniforms addObjectsFromArray:effect.fragmentUniforms];
    }
}

+(void)extractVertexData:(NSMutableArray*)effects functions:(NSMutableArray*)functions uniforms:(NSMutableArray*)uniforms
{
    // Check for duplicate names
    NSMutableDictionary* functionNames = [[NSMutableDictionary alloc] init];

    // Extract all fragment functions and uniforms
    for(CCEffect* effect in effects)
    {
        for(CCEffectFunction* function in effect.vertexFunctions)
        {
            if([functionNames objectForKey:function.name])
                continue;
            
            [functions addObject:function];
            [functionNames setObject:@YES forKey:function.name];
        }
        
        // TODO: check/handle uniforms with the same name
        [uniforms addObjectsFromArray:effect.vertexUniforms];
    }
}

@end
#endif
