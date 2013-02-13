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

#import "TagManager.h"
#import "Entity.h"
#import "World.h"

@implementation TagManager

-(id) initWithWorld:(World *)world
{
    if (self = [super initWithWorld:world])
    {
        _entitiesByTag = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) dealloc
{
    [_entitiesByTag release];
    
    [super dealloc];
}

-(void) registerEntity:(Entity *)entity withTag:(NSString *)tag
{
    [_entitiesByTag setObject:entity forKey:tag];
	[entity refresh];
}

-(Entity *) getEntity:(NSString *)tag
{
    return [_entitiesByTag objectForKey:tag];
}

-(void) removeEntity:(Entity *)entity
{
    for (NSString *tag in [_entitiesByTag allKeys])
    {
        Entity *anEntity = [_entitiesByTag objectForKey:tag];
        if (anEntity == entity)
        {
            [_entitiesByTag removeObjectForKey:tag];
            break;
        }
    }
	[entity refresh];
}

@end
