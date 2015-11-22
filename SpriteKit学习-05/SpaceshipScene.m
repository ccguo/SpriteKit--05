//
//  SpaceshipScene.m
//  SpriteKit学习-01
//
//  Created by guochaoyang on 15/11/18.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "SpaceshipScene.h"
#import "UIColor+Random.h"
#import "RainZone.h"

static inline CGFloat skRandf(){
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high){
    return skRandf() * (high - low) + low;
}

@interface SpaceshipScene ()
@property (nonatomic)BOOL contentCreated;
@end
@implementation SpaceshipScene

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [UIColor grayColor];
    if (!self.contentCreated) {
        [self createSceneEmitter];
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneEmitter
{
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"rain" ofType:@"sks"] ];
    emitter.position = CGPointMake(self.size.width*2/3, self.size.height);
    [self addChild:emitter];
}


- (void)createSceneContents
{
    self.backgroundColor = [UIColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    SKAction *makeRocks = [SKAction sequence:@[
                                               [SKAction performSelector:@selector(addRock) onTarget:self],
                                               [SKAction waitForDuration:0.5 withRange:0.15]
                                               ]];
    [self runAction:[SKAction repeatActionForever:makeRocks]];
}

- (void)addRock
{
    CGFloat reactAngle = skRand(30,70);
    
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[UIColor randomColor] size:CGSizeMake(reactAngle,reactAngle)];
//    rock.position = CGPointMake(skRand(rock.size.width/2,self.size.width-rock.size.width/2), self.size.height);
    rock.position = [RainZone randRainPosition];
    rock.name = @"rock";

    [self addChild:rock];
    
    
    SKAction *sequence = [SKAction group:@[
                                           [SKAction rotateByAngle:M_PI_4 duration:0.5],
                                           [SKAction speedBy:15 duration:10],
                                           [SKAction moveBy:CGVectorMake(-ScreenWidth-100, -ScreenHeight-100) duration:10]
                                          ]];
    [rock runAction:sequence];

}

- (void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop){
        if (node.position.y < 0) {
            [node removeFromParent];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    SKNode *currentNode = [self nodeAtPoint:point];
    
    if ([currentNode.name isEqualToString:@"rock"]) {
        [currentNode runAction:[SKAction removeFromParent]];
    }
    
}


@end
