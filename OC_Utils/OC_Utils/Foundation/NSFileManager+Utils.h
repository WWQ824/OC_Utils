//
//  NSFileManager+Utils.h
//  OC_Utils
//
//  Created by WWQ on 2021/8/11.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


extern NSString *UPathTemp(void);
extern NSString *UPathDocuments(void);
extern NSString *UPathDocumentsAppendingPathComponent(NSString *pathComponent);

@interface NSFileManager (Utils)


+ (void)u_setExcludedFromBackup:(BOOL)excluded forFileAtpath:(NSString *)path;

- (unsigned long long int)u_documentsFolderSize;

- (void)u_removeFileAtPath:(NSString *)path condition:(BOOL (^)(NSString *))condition;

+ (BOOL)u_removeItemIfExistsAtPath:(NSString *)path error:(NSError **)error;


@end

NS_ASSUME_NONNULL_END
