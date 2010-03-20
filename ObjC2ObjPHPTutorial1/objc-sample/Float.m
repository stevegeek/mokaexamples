#import <stdio.h>
#import "Float.h"

@implementation Float
{
  float value;
}

-initFloatValue: (float) x
{
  [super init];
  value = x;
  return self;
}

-report
{
  printf ("%4.1f", value);
  return self;
}

@end
