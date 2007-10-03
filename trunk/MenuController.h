/* MenuController */

#import <Cocoa/Cocoa.h>

@interface MenuController : NSObject
{
    IBOutlet NSMenu *WoTingMenu;
    IBOutlet NSTextField *Template;
    NSArray *itunes_info;
    NSString *current_template;
}
@end
@interface NSString(woting)
-(NSString *)replace:(NSString *)string with:(NSString *)string;
@end
