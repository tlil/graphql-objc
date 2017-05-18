#import "TimerJS.h"

@implementation TimerJS

TimerJS *timerJSSharedInstance;
NSMutableDictionary *timers;

+(instancetype)registerInto:(JSContext*)context {
    if (timerJSSharedInstance == nil) {
        timerJSSharedInstance = [[TimerJS alloc] init];
        timers = [[NSMutableDictionary alloc] init];
    }
    [context setObject:timerJSSharedInstance forKeyedSubscript:@"timerJS"];
    [context evaluateScript:
        @"function setTimeout(callback, ms) {"
        @"    return timerJS.setTimeout({callback, ms})"
        @"}"
        @"function clearTimeout(identifier) {"
        @"    timerJS.clearTimeout({identifier})"
        @"}"
        @"function setInterval(callback, ms) {"
        @"    return timerJS.setInterval({callback, ms})"
        @"}"
        @"function clearInterval(identifier) {"
        @"    timerJS.clearTimeout({identifier})"
        @"}"
     ];
    return timerJSSharedInstance;
}

-(NSString*)setTimeout:(JSValue*)args {
    double ms = args[@"ms"].toDouble;
    return [self createTimer:args[@"callback"] withInterval:ms andRepeats: false];
}

-(NSString*)setInterval:(JSValue*)args {
    double ms = args[@"ms"].toDouble;
    return [self createTimer:args[@"callback"] withInterval:ms andRepeats: true];
}

-(void)clearTimeout:(JSValue*)args {
    NSString *ident = args[@"identifier"].toString;
    NSTimer *timer = [timers valueForKey:ident];
    if (timer != nil) {
        [timer invalidate];
    }
    [timers removeObjectForKey:ident];
}

-(NSString*)createTimer:(JSValue*)callback withInterval:(double)ms andRepeats:(bool)repeats {
    double timeInterval  = ms/1000.0;
    NSString* uuid = [[[NSUUID alloc] init] UUIDString];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval repeats:repeats block:^(NSTimer * _Nonnull timer) {
            if (callback != nil) {
                [callback callWithArguments:[NSArray array]];
            }
        }];
        [timers setValue:timer forKey:uuid];
    });
    return uuid;
}

@end
