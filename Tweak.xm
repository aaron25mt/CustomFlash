#import <UIKit/UIKit.h>

@interface BBBulletinRequest : NSObject
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* message; 
@property (nonatomic, copy) NSString* sectionID;
@property (nonatomic, retain) NSDate* date;
@end

@interface SBBulletinBannerController
+(id)sharedInstance;
-(void)observer:(id)arg1 addBulletin:(id)arg2 forFeed:(unsigned long long)arg3;
-(void)observer:(id)arg1 addBulletin:(id)arg2 forFeed:(unsigned long long)arg3 playLightsAndSirens:(BOOL)arg4 withReply:(id)arg5;
@end

%hook SBScreenFlash
-(void)flashColor:(id)arg1 withCompletion:(id)arg2 {
	%orig([UIColor clearColor], arg2);
}

-(void)_orderWindowOut:(id)arg1 {
	%orig;
	BBBulletinRequest* banner = [[%c(BBBulletinRequest) alloc] init];
	[banner setTitle: @"CustomFlash"];
	[banner setMessage: @"Screenshot saved"];
	[banner setDate: [NSDate date]];
	[banner setSectionID: @"com.apple.camera"];
	if([%c(SBBulletinBannerController) instancesRespondToSelector:@selector(observer:addBulletin:forFeed:playLightsAndSirens:withReply:)]) {
		[(SBBulletinBannerController *)[%c(SBBulletinBannerController) sharedInstance] observer:nil addBulletin:banner forFeed:2 playLightsAndSirens:YES withReply:nil];
	} else {
		[(SBBulletinBannerController *)[%c(SBBulletinBannerController) sharedInstance] observer:nil addBulletin:banner forFeed:2];
	}
	[banner release];
}
%end