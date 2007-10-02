#import "TplDelegate.h"

@implementation TplDelegate
- (void)controlTextDidChange:(NSNotification *)aNotification
{
    [OkButton setValue:[NSNumber numberWithBool:YES] forKey:@"enabled"];
}
@end
