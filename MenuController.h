/* MenuController */

#import <Cocoa/Cocoa.h>

@interface MenuController : NSObject
{
    IBOutlet NSMenu *WoTingMenu;
    IBOutlet NSTextField *Template;
    NSArray *mItunesInfo;
    NSString *mCurrentTemplate;
    NSAppleScript	*mScriptObject;
	BOOL updating;
}
-(BOOL) updateInfo;
@end
@interface NSString(woting)
-(NSString *)replace:(NSString *)string with:(NSString *)string;
@end
