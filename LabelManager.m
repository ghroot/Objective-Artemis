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

#import "LabelManager.h"
#import "Entity.h"

@implementation LabelManager

-(id) initWithWorld:(World *)world
{
    if (self = [super initWithWorld:world])
    {
        _labelsByEntity = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) dealloc
{
    [_labelsByEntity release];
    
    [super dealloc];
}

-(void) labelEntity:(Entity *)entity withLabel:(NSString *)labelName
{
	NSMutableArray *labelsForEntity;
	if ([_labelsByEntity objectForKey:entity] == nil)
	{
		labelsForEntity = [[[NSMutableArray alloc] init] autorelease];
		[_labelsByEntity setObject:labelsForEntity forKey:[entity entityId]];
	}
	else
	{
		labelsForEntity = [_labelsByEntity objectForKey:[entity entityId]];
	}
	[labelsForEntity addObject:labelName];
	[entity refresh];
}

-(BOOL) hasEntity:(Entity *)entity label:(NSString *)labelName
{
    if ([_labelsByEntity objectForKey:[entity entityId]] != nil)
    {
        NSArray *labelsForEntity = [_labelsByEntity objectForKey:[entity entityId]];
        return [labelsForEntity containsObject:labelName];
    }
    else
    {
		return FALSE;
    }
}

-(void) unLabelEntity:(Entity *)entity withLabel:(NSString *)labelName
{
    if ([_labelsByEntity objectForKey:[entity entityId]] != nil)
    {
        NSMutableArray *labelsForEntity = [_labelsByEntity objectForKey:[entity entityId]];
        if ([labelsForEntity containsObject:labelName])
        {
            [labelsForEntity removeObject:labelName];
        }
    }
	[entity refresh];
}

-(void) removeEntity:(Entity *)entity
{
	if ([_labelsByEntity objectForKey:[entity entityId]] != nil)
	{
		[_labelsByEntity removeObjectForKey:[entity entityId]];
	}
	[entity refresh];
}

@end
