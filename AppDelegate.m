//
//  AppDelegate.m
//  SortingAlgorithms
//
//  Created by Logan on 12/5/12.
//  Copyright (c) 2012 Logan. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[NSNumber numberWithInt:635]];
    [items addObject:[NSNumber numberWithInt:123]];
    [items addObject:[NSNumber numberWithInt:404]];
    [items addObject:[NSNumber numberWithInt:973]];
    [items addObject:[NSNumber numberWithInt:862]];
    
    NSLog(@"%@", items);
    
    items = [self radixSort:items];
    
    NSLog(@"%@", items);
}

- (NSMutableArray *) radixSort: (NSMutableArray *) items
{
    int shift = 1;
    int max = [[items objectAtIndex:0] intValue];
    for (int i = 1; i < items.count; i++)
        if ([[items objectAtIndex:i] intValue] > max)
            max = [[items objectAtIndex:i] intValue];
    int toPlace = ceil((log10(max)));
    
    NSMutableArray *buckets = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
        [buckets addObject:[[NSMutableArray alloc] init]];
    
    for (int i = 0; i <= toPlace; i++)
     {
        for (int j = 0; j < items.count; j++)
         {
            int bucketNumber = ([[items objectAtIndex:j] intValue] / shift) % 10;
            [[buckets objectAtIndex:bucketNumber] addObject:[items objectAtIndex:j]];
         }
        NSMutableArray *combineBuckets = [[NSMutableArray alloc] init];
        for (int k = 0; k < [buckets count]; k++)
         {
            [combineBuckets addObjectsFromArray:[buckets objectAtIndex:k]];
            [[buckets objectAtIndex:k] removeAllObjects];
         }

        items = [NSMutableArray arrayWithArray:combineBuckets];
        shift *= 10;
     }
    return items;
}

@end
