#import <objc/Object.h>
#import "Node.h"

@interface Queue: Object
{
  id head;
  id tail;
  unsigned qsize;
}

-empty;			// clear out all contents of the Queue
-put: anItem;		// put anItem on the Queue
-get;			// return the item on top of the Queue
-(unsigned int) size;	// tell us the current size of the Queue

@end
