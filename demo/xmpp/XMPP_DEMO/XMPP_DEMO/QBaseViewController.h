//
//  QBaseViewController.h
//  XMPP_DEMO
//
//  Created by andy on 10/1/14.
//  Copyright (c) 2014 streakq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

@interface QBaseViewController : UIViewController
{
    XMPPStream *_xmppStream;

    BOOL _isOpen;
}
@property (nonatomic, strong, readonly) XMPPStream *xmppStream;

@end
