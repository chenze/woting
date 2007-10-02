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
   
    current_template=[[NSString alloc] initWithString:[Template stringValue]];
}
-(IBAction)ok:(id)sender
{
    NSUserDefaults *nsu=[NSUserDefaults standardUserDefaults];
	[nsu setObject:[Template stringValue] forKey:@"MenuDisplayTemplate"];
    [nsu synchronize];
    [OkButton setValue:[NSNumber numberWithBool:NO] forKey:@"enabled"];
}
- (IBAction)cancel:(id)sender
{
    [ConfigureWindow orderOut:sender];
    [Template setStringValue:current_template];
    [OkButton setValue:[NSNumber numberWithBool:NO] forKey:@"enabled"];
}
@end
