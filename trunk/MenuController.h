/* MenuController */

#import <Cocoa/Cocoa.h>

@interface MenuController : NSObject
{
    IBOutlet NSMenu *WoTingMenu;
    IBOutlet NSTextField *Template;
    NSString *current_template;
    NSString *current_title;
    NSString *current_artist;
    NSString *current_album;
}
@end
@interface NSString(woting)
-(NSString *)replace:(NSString *)string with:(NSString *)string;
@end
