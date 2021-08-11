//
//  NSFileManager+Utils.m
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import "NSFileManager+Utils.h"
#import <UIKit/UIKit.h>
#import <sys/xattr.h>

NSString *UPathTemp(void) {
    return NSTemporaryDirectory();
}


NSString *UPathDocuments(void) {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}


NSString *UPathDocumentsAppendingPathComponent(NSString *pathComponent) {
    return [UPathDocuments() stringByAppendingPathComponent:pathComponent];
}


@implementation NSFileManager (Utils)


+ (void)u_setExcludedFromBackup:(BOOL)excluded forFileAtpath:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSString *currentSystemVersion = [[UIDevice currentDevice] systemVersion];
    if ([currentSystemVersion compare:@"5.1"] != NSOrderedAscending) {
        [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil];
    }
    else if ([currentSystemVersion compare:@"5.0.1"] != NSOrderedAscending) {
        const char* filePath = [[url path] fileSystemRepresentation];
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    }
}


- (unsigned long long int)u_documentsFolderSize {
    NSString *_documentsDirectory = UPathDocuments();
    NSArray *_documentsFileList;
    NSEnumerator *_documentsEnumerator;
    NSString *_documentFilePath;
    unsigned long long int _documentsFolderSize = 0;
    
    _documentsFileList = [self subpathsAtPath:_documentsDirectory];
    _documentsEnumerator = [_documentsFileList objectEnumerator];
    while (_documentFilePath = [_documentsEnumerator nextObject]) {
        NSDictionary *_documentFileAttributes = [self attributesOfItemAtPath:[_documentsDirectory stringByAppendingPathComponent:_documentFilePath] error:nil];
        _documentsFolderSize += [_documentFileAttributes fileSize];
    }
    
    return _documentsFolderSize;
}


- (void)u_removeFileAtPath:(NSString *)path condition:(BOOL (^)(NSString *))condition {
    NSArray *files = [self contentsOfDirectoryAtPath:path error:nil];
    for (NSString *filePath in files) {
        NSString *fullPath = [path stringByAppendingPathComponent:filePath];
        if (condition(fullPath)) {
            [self removeItemAtPath:fullPath error:nil];
        }
    }
}


+ (BOOL)u_removeItemIfExistsAtPath:(NSString *)path error:(NSError **)error {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
    } else {
        return NO;
    }
}


@end
