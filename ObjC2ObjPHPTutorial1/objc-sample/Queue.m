#import "Queue.h"

@implementation	Queue

-empty
{
  while([self size])
    [[self get] free];
  return self;
}

-put: anItem
{
  if (tail)
    tail = [[tail setNext : [[Node alloc] init: anItem]] next];
  else
    head = tail = [[Node alloc] init: anItem];
  ++qsize;
  return self;
}

-get
{
  id contents;
  id old_head = head;

  head = [head next];
  contents = [old_head free];
  if (--qsize == 0)
    tail = head;
  return contents;
}

-(unsigned) size
{
  return qsize;
}

@end
