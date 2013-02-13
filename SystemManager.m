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

#import "SystemManager.h"
#import "EntitySystem.h"
#import "World.h"

@implementation SystemManager

@synthesize systems = _systems;

-(id) initWithWorld:(World *)world
{
    if (self = [super initWithWorld:world])
    {
        _systems = [[NSMutableArray alloc] init];
    }
    return self;
}

-(EntitySystem *) setSystem:(EntitySystem *)system
{
    [system setWorld:_world];
    [_systems addObject:system];
    return system;
}

-(id) getSystem:(Class)systemClass
{
    EntitySystem *systemToReturn = NULL;
    for (EntitySystem *system in _systems)
    {
        if ([system isKindOfClass:systemClass])
        {
            systemToReturn = system;
            break;
        }
    }
    return systemToReturn;
}

-(void) initialiseAll
{
    for (EntitySystem *system in _systems)
    {
        [system initialise];
    }
}

-(void) processAll
{
    for (EntitySystem *system in _systems)
    {
        [system process];
    }
}

-(void) dealloc
{
    [_systems release];
    
    [super dealloc];
}

@end
