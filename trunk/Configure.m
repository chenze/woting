#import "Configure.h"

@implementation Configure
-(void)awakeFromNib
{
    NSString *default_tpl = [[NSUserDefaults standardUserDefaults] stringForKey:@"MenuDisplayTemplate"];
    if (default_tpl!=nil) {
        [Template setStringValue:default_tpl];
    } else {
        [self ok:nil];
    }
   
    mCurrentTemplate=[[NSString alloc] initWithString:[Template stringValue]];
}
-(IBAction)ok:(id)sender
{
    NSUserDefaults *nsu=[NSUserDefaults standardUserDefaults];
	[nsu setObject:[Template stringValue] forKey:@"MenuDisplayTemplate"];
    mCurrentTemplate=[[NSString alloc] initWithString:[Template stringValue]];
    [nsu synchronize];
    [OkButton setValue:[NSNumber numberWithBool:NO] forKey:@"enabled"];
}
- (IBAction)cancel:(id)sender
{
    [ConfigureWindow orderOut:sender];
    [Template setStringValue:mCurrentTemplate];
    [OkButton setValue:[NSNumber numberWithBool:NO] forKey:@"enabled"];
}
@end
