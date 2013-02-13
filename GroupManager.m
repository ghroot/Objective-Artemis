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

#import "GroupManager.h"
#import "Entity.h"
#import "World.h"

@implementation GroupManager

-(id) initWithWorld:(World *)world
{
    if (self = [super initWithWorld:world])
    {
        _entitiesByGroupName = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) dealloc
{
    [_entitiesByGroupName release];
    
    [super dealloc];
}

-(void) addEntity:(Entity *)entity toGroup:(NSString *)groupName
{
    NSMutableArray *entitiesInGroup;
    if ([_entitiesByGroupName objectForKey:groupName] == nil)
    {
        entitiesInGroup = [[[NSMutableArray alloc] init] autorelease];
        [_entitiesByGroupName setObject:entitiesInGroup forKey:groupName];
    }
    else
    {
        entitiesInGroup = [_entitiesByGroupName objectForKey:groupName];
    }
    [entitiesInGroup addObject:entity];
	[entity refresh];
}

-(NSArray *) getEntitiesInGroup:(NSString *)groupName
{
    if ([_entitiesByGroupName objectForKey:groupName] != nil)
    {
        NSArray *entitiesInGroup = [_entitiesByGroupName objectForKey:groupName];
        return entitiesInGroup;
    }
    else
    {
        // Return empty array
        return [NSArray array];
    }
}

-(void) removeEntity:(Entity *)entity fromGroup:(NSString *)groupName
{
    if ([_entitiesByGroupName objectForKey:groupName] != nil)
    {
        NSMutableArray *entitiesInGroup = [_entitiesByGroupName objectForKey:groupName];
        if ([entitiesInGroup containsObject:entity])
        {
            [entitiesInGroup removeObject:entity];
        }
    }
	[entity refresh];
}

-(BOOL) isEntity:(Entity *)entity inGroup:(NSString *)groupName
{
	if ([_entitiesByGroupName objectForKey:groupName] != nil)
    {
        NSMutableArray *entitiesInGroup = [_entitiesByGroupName objectForKey:groupName];
        if ([entitiesInGroup containsObject:entity])
        {
            return TRUE;
        }
    }
	return FALSE;
}

-(void) removeEntity:(Entity *)entity
{
	for (NSString *groupName in [_entitiesByGroupName allKeys])
	{
		NSMutableArray *entitiesInGroup = [_entitiesByGroupName objectForKey:groupName];
        if ([entitiesInGroup containsObject:entity])
        {
            [entitiesInGroup removeObject:entity];
        }
	}
	[entity refresh];
}

@end
