#import <objc/Object.h>
#import "Node.h"

@implementation	Node: Object

-init: anItem
{
  self = [super init];
  next = 0;
  data = anItem;
  return self;
}

-free
{
  id tmp = data;
  [super free];
  return tmp;
}

-next
{
  return next;
}

-setNext: aNode
{
  next = aNode;
  return self;
}

@end
