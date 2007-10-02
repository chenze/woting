/* Configure */

#import <Cocoa/Cocoa.h>

@interface Configure : NSObject
{
    IBOutlet id ConfigureWindow;
    IBOutlet NSTextField *Template;
    IBOutlet NSButton *OkButton;
    NSString *current_template;
}
- (IBAction)cancel:(id)sender;
- (IBAction)ok:(id)sender;
@end
