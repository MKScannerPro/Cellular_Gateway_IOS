//
//  MKCKImportServerController.h
//  MKCellular_Example
//
//  Created by aa on 2023/12/25.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCKImportServerControllerDelegate <NSObject>

- (void)ck_selectedServerParams:(NSString *)fileName;

@end

@interface MKCKImportServerController : MKBaseViewController

@property (nonatomic, weak)id <MKCKImportServerControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
