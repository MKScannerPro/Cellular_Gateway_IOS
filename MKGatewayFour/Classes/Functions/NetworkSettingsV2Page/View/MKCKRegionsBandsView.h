//
//  MKCKRegionsBandsView.h
//  MKGatewayFour_Example
//
//  Created by aa on 2025/2/18.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCKRegionsBandsView : UIView

/*
 Bit0:US
 BIT1:EU
 BIT2:KR
 BIT3:AU
 BIT4:ME
 BIT5:JP
 BIT6:CN
 BIT7:全世界
 Bit0~bit6同时只能配置2个区域，如果选择了bit7则只能配置为bit7
 默认为0X80

 */
@property (nonatomic, assign)NSInteger regionsBands;

- (NSInteger)fetchCurrentRegion;

@end

NS_ASSUME_NONNULL_END
