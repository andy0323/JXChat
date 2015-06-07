//
//  QBaseViewController.m
//  XMPP_DEMO
//
//  Created by andy on 10/1/14.
//  Copyright (c) 2014 streakq. All rights reserved.
//

#import "QBaseViewController.h"

@interface QBaseViewController ()

@end

@implementation QBaseViewController

- (BOOL)connect
{
    if (![_xmppStream isDisconnected]) {
        return YES;
    }
    
    [_xmppStream setMyJID:[XMPPJID jidWithString:@"huangxiaolong@andy.local"]];
    [_xmppStream setHostName:@"192.168.1.63"];

    NSError *error = nil;
    if (![_xmppStream connectWithTimeout:10.0f error:&error]) {
        NSLog(@"cant connect");
        return NO;
    }
    
    return YES;
}

-(void)goOnline
{
    //发送在线状态
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
}

-(void)goOffline
{
    //发送下线状态
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}

- (void)sendMessage
{
    NSString *message = @"hi";

    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:message];

    NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
    [mes addAttributeWithName:@"type" stringValue:@"chat"];
    [mes addAttributeWithName:@"to" stringValue:@"jinjianxiang@andy.local"];
    [mes addAttributeWithName:@"from" stringValue:@"huangxiaolong@andy.local"];
    [mes addChild:body];
    [[self xmppStream] sendElement:mes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self
               delegateQueue:dispatch_get_current_queue()];

    BOOL isConnected = [self connect];
    NSLog(@"%d", isConnected);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self sendMessage];
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{    
    _isOpen = YES;
    NSError *error = nil;
    //验证密码
    [[self xmppStream] authenticateWithPassword:@"123456" error:&error];
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    [self goOnline];
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    //取得好友状态
    NSString *presenceType = [presence type]; //online/offline
    //当前用户
    NSString *userId = [[sender myJID] user];
    //在线用户
    NSString *presenceFromUser = [[presence from] user];
    
    if (![presenceFromUser isEqualToString:userId]) {
        
        //在线状态
        if ([presenceType isEqualToString:@"available"]) {
            
            NSLog(@"在线用户： %@", presenceFromUser);
            
        }else if ([presenceType isEqualToString:@"unavailable"]) {

            NSLog(@"不在线用户： %@", presenceFromUser);
            
        }
    }
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];

    NSLog(@"%@", msg);
    NSLog(@"%@", from);
}

@end
