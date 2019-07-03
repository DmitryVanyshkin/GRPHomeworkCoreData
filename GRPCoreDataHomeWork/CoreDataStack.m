//
//  CoreDataStack.m
//  GRPCoreDataHomeWork
//
//  Created by Дмитрий Ванюшкин on 26/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "CoreDataStack.h"

@implementation CoreDataStack

+ (instancetype)shared
{
    static dispatch_once_t once;
    static CoreDataStack *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [CoreDataStack new];
    });
    return sharedInstance;
}

-(NSPersistentContainer *)container
{
    @synchronized (self)
    {
        if (_container)
        {
            return _container;
        }
        _container = [NSPersistentContainer persistentContainerWithName:@"GRPIndexStack"];
        [_container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull desc, NSError * _Nullable error) {
            if (error)
            {
                NSLog(@"Error: %@", error.localizedDescription);
                abort();
            }
        }];
        return _container;
    }
}

@end
