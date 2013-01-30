//
//  UTOfflineCache.m
//  RingFinder
//
//  Created by Danny Morrow on 1/29/13.
//  Copyright (c) 2013 unitytheory. All rights reserved.
//

#import "UTOfflineCache.h"
#import "NSStringAdditions.h"

static UTOfflineCache *sharedInstance = nil;

@implementation UTOfflineCache


+ (UTOfflineCache *) sharedCache
{
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        sharedInstance = [[UTOfflineCache alloc] init];
        [sharedInstance setStoragePath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"UTOfflineCache"]];
    });
    
    return sharedInstance;
}

- (NSString *)storagePath
{
	return _storagePath;
}

- (void)setStoragePath:(NSString *)path
{
	_storagePath = path;
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	BOOL isDirectory = NO;
    BOOL exists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    if (exists && !isDirectory)
    {
        [NSException raise:@"FileExistsAtCachePath" format:@"Cannot create a directory for the cache at '%@', because a file already exists",path];
    }
    else if (!exists)
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (![fileManager fileExistsAtPath:path])
        {
            [NSException raise:@"FailedToCreateCacheDirectory" format:@"Failed to create a directory for the cache at '%@'",path];
        }
    }
}

- (void)storeData:(NSData*)data fromURL:(NSURL*) url
{
	if (data)
    {
        NSString *dataPath = [self pathToDataForURL:url];
        NSError* error;
		[data writeToFile:dataPath options:NSDataWritingAtomic error:&error];
    }
}

- (void) removeCachedDataForURL:(NSURL *)url
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	NSString* path = [self pathToDataForURL:url];
	if (path) [fileManager removeItemAtPath:path error:NULL];
}

- (NSData*) cachedDataForURL:(NSURL *)url
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* path = [self pathToDataForURL:url];
	if (path) return [fileManager contentsAtPath:path];
    return nil;
}

- (BOOL) hasCachedDataForURL:(NSURL *)url
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self pathToDataForURL:url]];
}

- (NSString *)pathToDataForURL:(NSURL *)url
{
	NSString *extension = [[url path] pathExtension];
    NSString *path =   [[self storagePath] stringByAppendingPathComponent:[[[self class] keyForURL:url] stringByAppendingPathExtension:extension]];
	return path;
}

+ (NSString *) keyForURL:(NSURL*)url
{
    return [url.absoluteString md5HexDigest];
}





@end
