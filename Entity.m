/**
* Based on Artemis Entity System Framework
* 
* Copyright 2011 GAMADU.COM. All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
* 
*    1. Redistributions of source code must retain the above copyright notice, this list of
*       conditions and the following disclaimer.
* 
*    2. Redistributions in binary form must reproduce the above copyright notice, this list
*       of conditions and the following disclaimer in the documentation and/or other materials
*       provided with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY GAMADU.COM ``AS IS'' AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL GAMADU.COM OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
* ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
* ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* 
* The views and conclusions contained in the software and documentation are those of the
* authors and should not be interpreted as representing official policies, either expressed
* or implied, of GAMADU.COM.
*/

#import "Entity.h"
#import "Component.h"
#import "EntityManager.h"
#import "World.h"

@implementation Entity

@synthesize entityId = _entityId;
@synthesize world = _world;
@synthesize deleted = _deleted;

-(id) initWithWorld:(World *)world andId:(NSNumber *)entityId
{
    if (self = [super init])
    {
        _world = world;
        _entityManager = [_world entityManager];
        _entityId = [entityId retain];
    }
    return self;
}

-(void) dealloc
{
	[_entityId release];
	
	[super dealloc];
}

-(void) addComponent:(Component *)component
{
    [_entityManager addComponent:component toEntity:self];
}

-(BOOL) hasComponent:(Class)componentClass
{
    return [self getComponent:componentClass] != nil;
}

-(void) removeComponent:(Component *)component
{
    [_entityManager removeComponent:component fromEntity:self];
}

-(Component *) getComponent:(Class)componentClass;
{
    return [_entityManager getComponentWithClass:componentClass fromEntity:self];
}

-(NSArray *) getComponents
{
	return [_entityManager getComponents:self];
}

-(void) refresh
{
    [_world refreshEntity:self];
}

-(void) deleteEntity
{
    [_world deleteEntity:self];
}

@end
