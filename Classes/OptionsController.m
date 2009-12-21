#import "SOApplication.h"

unsigned long gp2x_fps_debug = 0;
int __autosave = 0;
int __wiimote = 0;

@implementation OptionsController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)awakeFromNib
{
	self.navigationItem.hidesBackButton = YES;
		
	[self getOptions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

- (void)optionChanged:(id)sender
{
	[optionsArray removeAllObjects];
	[optionsArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
							 [NSString stringWithFormat:@"%d", segmentedSkin.selectedSegmentIndex], @"skin",
							 [NSString stringWithFormat:@"%d", [switchScaling isOn]], @"scaling",
							 [NSString stringWithFormat:@"%d", [switchAutosave isOn]], @"autosave",
               [NSString stringWithFormat:@"%d", [switchWiiMote isOn]], @"wiimote",
							 [NSString stringWithFormat:@"%d", [switchFramerate isOn]], @"framerate",
               [NSString stringWithFormat:@"%d", [switchSmoothScaling isOn]], @"smoothscaling",
							 nil]];	
	
 	[segmentedSkin setSelectedSegmentIndex:[[[optionsArray objectAtIndex:0] objectForKey:@"skin"] intValue]];
 	[switchScaling setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"scaling"] intValue] animated:NO];
 	[switchAutosave setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"autosave"] intValue] animated:NO];
 	[switchWiiMote setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"wiimote"] intValue] animated:NO];
 	[switchFramerate setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"framerate"] intValue] animated:NO];
  [switchSmoothScaling setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"smoothscaling"] intValue] animated:NO];
  
 	gp2x_fps_debug = [switchFramerate isOn];
 	__autosave = [switchAutosave isOn];
 	__wiimote = [switchWiiMote isOn];
	
	NSString *path=[[self getDocumentsDirectory] stringByAppendingPathComponent:@"options.bin"];
	NSData *plistData;
	
	NSString *error;
	
	
	
	plistData = [NSPropertyListSerialization dataFromPropertyList:optionsArray
				 
														   format:NSPropertyListBinaryFormat_v1_0
				 
												 errorDescription:&error];
	
	if(plistData)
		
	{
		
		NSLog(@"No error creating plist data.");
		
		[plistData writeToFile:path atomically:NO];
		
	}
	else
	{
		
		NSLog(error);
		
		[error release];
		
	}	
}

- (int)getCurrentSkin
{
	return segmentedSkin.selectedSegmentIndex;
}

- (int)getCurrentScaling
{
	return [switchScaling isOn];
}

- (int)getCurrentSmoothScaling
{
	return [switchSmoothScaling isOn];
}

- (NSString*)getDocumentsDirectory
{
#ifdef APPSTORE_BUILD
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex: 0];
	return documentsDirectory;
#else
	return @"/Applications/n64iphone.app";
#endif
}

- (void)getOptions
{
	NSString *path=[[self getDocumentsDirectory] stringByAppendingPathComponent:@"options.bin"];
	
	NSData *plistData;
	id plist;
	NSString *error;
	
	NSPropertyListFormat format;
	
	plistData = [NSData dataWithContentsOfFile:path];
	
	
	
	plist = [NSPropertyListSerialization propertyListFromData:plistData
			 
											 mutabilityOption:NSPropertyListImmutable
			 
													   format:&format
			 
											 errorDescription:&error];
	
	if(!plist)
	{
		
		NSLog(error);
		
		[error release];
		
		optionsArray = [[NSMutableArray alloc] init];
		
		[segmentedSkin setSelectedSegmentIndex:0];
		[switchScaling setOn:1 animated:NO];
		[switchAutosave setOn:0 animated:NO];
		[switchSmoothScaling setOn:0 animated:NO];
		[switchFramerate setOn:0 animated:NO];
		[switchWiiMote setOn:0 animated:NO];
		
		[self optionChanged:self];
	}
	else
	{
		optionsArray = [[NSMutableArray alloc] initWithArray:plist];
		
		[segmentedSkin setSelectedSegmentIndex:[[[optionsArray objectAtIndex:0] objectForKey:@"skin"] intValue]];
		[switchScaling setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"scaling"] intValue] animated:NO];
		[switchAutosave setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"autosave"] intValue] animated:NO];
		[switchSmoothScaling setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"smoothscaling"] intValue] animated:NO];
		[switchWiiMote setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"wiimote"] intValue] animated:NO];
		[switchFramerate setOn:[[[optionsArray objectAtIndex:0] objectForKey:@"framerate"] intValue] animated:NO];
		
		[self optionChanged:self];
	}
}

@end
