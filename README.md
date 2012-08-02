JTabBarTableViewController
==========================

First, thanks for "JTabBarTableViewController" form stuartjmoore and "MHTabBarController" from hollance.Those brilliant libraries help me implement JTabBarTableViewController.

Just some simple steps: (Take look at Demo Classes)
1. Create a customized viewcontroller which is extended to JTTabTableViewController:

@interface RootViewController : JTTabTableViewController

2. Create customized tableviews which are extended to JTTabTableView, add UITableViewDelegate and UITableviewDataSource as well:

@interface aTabTableView : JTTabTableView <UITableViewDelegate, UITableViewDataSource>

3. Assign your cusomized tableviews to your customized viewcontrollers:
	
		aTabTableView * aTableView = [[aTabTableView alloc]init];
        aTableView.tabTitle = @"Tab A";
        aTableView.delegate = aTableView;
        aTableView.dataSource = aTableView;
        
        bTabTableView * bTableView = [[bTabTableView alloc]init];
        bTableView.tabTitle = @"Tab B";
        bTableView.delegate = bTableView;
        bTableView.dataSource = bTableView;
        
        self.tableviews = [NSArray arrayWithObjects:aTableView, bTableView, nil];
	(Important: assign tablviewDelegate and tableviewDataSource to each tableview self)

Just three steps, Done !