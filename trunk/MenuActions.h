/* MenuActions */

#import <Cocoa/Cocoa.h>

@interface MenuActions : NSObject
{
    IBOutlet id ConfigureWindow;
}
- (IBAction)close:(id)sender;
- (IBAction)config:(id)sender;
- (IBAction)homepage:(id)sender;
@end