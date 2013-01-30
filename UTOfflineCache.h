//
//  UTOfflineCache.h
//  RingFinder
//
//  Created by Danny Morrow on 1/29/13.
//  Copyright (c) 2013 unitytheory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTOfflineCache : NSObject
{
    NSString* _storagePath;
}

@property (nonatomic, strong) NSString *storagePath;


- (void) storeData:(NSData*)data fromURL:(NSURL*) url;
- (NSString *) pathToDataForURL:(NSURL *)url;
- (void) removeCachedDataForURL:(NSURL *)url;
- (BOOL) hasCachedDataForURL:(NSURL *) url;
- (NSData*) cachedDataForURL:(NSURL *)url;

+ (NSString *) keyForURL:(NSURL*)url;
+ (UTOfflineCache *) sharedCache;
@end
