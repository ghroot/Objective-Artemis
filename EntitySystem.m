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

#import "EntitySystem.h"
#import "Entity.h"

@implementation EntitySystem

@synthesize world = _world;
@synthesize active = _active;

+(id) system
{
	return [[self new] autorelease];
}

-(id) init
{
    if (self = [super init])
    {
        _entities = [[NSMutableArray alloc] init];
		_active = TRUE;
    }
    return self;
}

-(void) dealloc
{
    [_entities release];
    
    [super dealloc];
}

-(void) initialise
{
}

-(void) begin
{
}

-(void) process
{
    [self begin];
    [self processEntities:_entities];
    [self end];
}

-(void) end
{
}

-(void) processEntities:(NSArray *)entities
{
    for (Entity *entity in entities)
    {
        [self processEntity:entity];
    }
}

-(void) processEntity:(Entity *)entity
{
}

-(void) entityAdded:(Entity *)entity
{
}

-(void) entityRemoved:(Entity *)entity
{
}

-(void) entityChanged:(Entity *)entity
{
    BOOL shouldBeInThisSystem = [self shouldContainEntity:entity];
    if ([_entities containsObject:entity] && (!shouldBeInThisSystem || [entity deleted]))
    {
        [self removeEntity:entity];
    }
    else if (![_entities containsObject:entity] && shouldBeInThisSystem)
    {
        [_entities addObject:entity];
        [self entityAdded:entity];
    }
}

-(BOOL) shouldContainEntity:(Entity *)entity
{
	return FALSE;
}

-(void) removeEntity:(Entity *)entity
{
    [_entities removeObject:entity];
    [self entityRemoved:entity];
}

-(BOOL) hasEntity:(Entity *)entity
{
    return [_entities containsObject:entity];
}

-(void) deactivate
{
	_active = FALSE;
}

-(void) activate
{
	_active = TRUE;
}

@end
