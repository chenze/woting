#import "MenuController.h"

static NSStatusItem *statusItem;
@implementation MenuController
-(void)awakeFromNib
{
    statusItem=[[[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength] retain];
	
    //NSLog(@"number:%d",[WoTingMenu numberOfItems]);
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:WoTingMenu];
    [statusItem setEnabled:YES];
    [statusItem setTitle:@"WT"];
    [statusItem setMenu:WoTingMenu];
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateInfo:) userInfo:nil repeats:YES];
    [t fire];
}
-(id) init
{
    return self;
}
-(BOOL) updateInfo:(NSTimer*)timer
{
    NSDictionary		*errorDict;
    NSAppleEventDescriptor 	*returnDescriptor;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"itunes" ofType:@"scpt" inDirectory:@"Scripts"];
    
    NSURL *scriptURL = [[NSURL alloc] initFileURLWithPath:path];
    
    NSAppleScript	*scriptObject = [[NSAppleScript alloc] initWithContentsOfURL:scriptURL error:&errorDict];
    returnDescriptor=[scriptObject executeAndReturnError: &errorDict];
    [scriptObject release];
   
    if (kAENullEvent!=[returnDescriptor descriptorType] && [returnDescriptor numberOfItems]>0) {
        NSString *new_title = [[returnDescriptor descriptorAtIndex:1] stringValue];
        NSString *new_artist = [[returnDescriptor descriptorAtIndex:2] stringValue];
        NSString *new_album = [[returnDescriptor descriptorAtIndex:3] stringValue];
        NSString *new_tpl= [[NSUserDefaults standardUserDefaults] stringForKey:@"MenuDisplayTemplate"];
        
        if (new_title==nil)  new_title=@"";
        if (new_artist==nil)  new_artist=@"";
        if (new_album==nil)  new_album=@"";
        if (new_tpl==nil)  new_tpl=[Template stringValue];
        if ([new_title isEqualToString:current_title] 
            && [new_artist isEqualToString:current_artist] 
            && [new_album isEqualToString:current_album]
            && [new_tpl isEqualToString:current_template]) {
            return NO;
        }
        
        current_title=[[NSString alloc] initWithString:new_title];
        current_artist=[[NSString alloc] initWithString:new_artist];
        current_album=[[NSString alloc] initWithString:new_album];
        current_template = [[NSString alloc] initWithString:new_tpl];
        
        
        
        new_tpl = [new_tpl replace:@"$title" with:current_title];
        new_tpl = [new_tpl replace:@"$artist" with:current_artist];
        new_tpl = [new_tpl replace:@"$album" with:current_album];
        
        //NSLog(@"%@",new_tpl);
        [statusItem setTitle:new_tpl];
        return YES;
    }
    return NO;
}
@end
@implementation NSString(woting)
-(NSString *)replace:(NSString *)find_str with:(NSString *)replace_str
{	
    if (replace_str==nil) replace_str = [NSString string];
    NSRange str_range,head_range,find_range;
    unsigned int left_length,current_position=0;
    NSMutableString * buffer=[NSMutableString string];
    left_length=[self length];
    while (YES) {
        find_range=NSMakeRange(current_position,left_length);
        str_range=[self rangeOfString:find_str options:nil range:find_range];
        if (str_range.location==NSNotFound) {
            [buffer appendString:[self substringWithRange:find_range]];
            break;
        } else {
            head_range = NSMakeRange(current_position,str_range.location-current_position);
            left_length = left_length - (str_range.location-current_position+str_range.length);
            current_position = str_range.location+str_range.length;
            [buffer appendString:[self substringWithRange:head_range]];
            [buffer appendString:replace_str];
        }
        
    }
    return buffer;
}
@end
