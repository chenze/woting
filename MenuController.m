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
    //NSArray *nma= ;
    itunes_info=[NSArray arrayWithObjects:
        [NSMutableArray arrayWithObjects:@"$title",@"",nil],
        [NSMutableArray arrayWithObjects:@"$artist",@"",nil],
        [NSMutableArray arrayWithObjects:@"$album",@"",nil],
        [NSMutableArray arrayWithObjects:@"$genre",@"",nil],
        [NSMutableArray arrayWithObjects:@"$time",@"",nil],
        nil
        ];
    [itunes_info retain];
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
        //NSEnumerator *itunes_items = [itunes_info objectEnumerator];
        //NSMutableArray *itunes_item;
        int current_index;
        int desc_index;
        BOOL is_different = NO;
        //int c = 3;
        //NSLog(@"%d",[itunes_info count]);
        NSString *new_str;
        for (current_index=0;current_index<[itunes_info count];current_index++) {
            //itunes_item = [itunes_info objectAtIndex:current_index];
           // new_str=[[NSString alloc] initWithString:[[returnDescriptor descriptorAtIndex:current_index] stringValue]];
            desc_index=current_index+1;
            new_str=[[returnDescriptor descriptorAtIndex:desc_index] stringValue];
            if (new_str==nil)  new_str=@"";
            if (is_different == NO && [new_str isEqualToString:[[itunes_info objectAtIndex:current_index]objectAtIndex:1]]==NO) {
                is_different = YES;
            }
            [[itunes_info objectAtIndex:current_index]replaceObjectAtIndex:1 withObject:[[NSString alloc] initWithString:new_str]];
        }
        NSString *new_tpl= [[NSUserDefaults standardUserDefaults] stringForKey:@"MenuDisplayTemplate"];
        if (new_tpl==nil)  new_tpl=[Template stringValue];
        if (is_different==NO && [new_tpl isEqualToString:current_template]) {
        	return NO;
        }
        current_template = [[NSString alloc] initWithString:new_tpl];
        
        NSEnumerator *itunes_items = [itunes_info objectEnumerator];
        id item;
        while (item = [itunes_items nextObject]) {
            new_tpl = [new_tpl replace:[item objectAtIndex:0] with:[item objectAtIndex:1]];
        }
        [statusItem setTitle:new_tpl];
        NSLog(@"%@",new_tpl);
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
