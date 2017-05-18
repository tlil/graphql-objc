#import "TimerJS.h"

@implementation NSTimer (Blocks)

+(id)scheduledTimerWithTimeIntervalWrap:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(jdExecuteSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(jdExecuteSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+(void)jdExecuteSimpleBlock:(NSTimer *)inTimer;
{
    if([inTimer userInfo])
    {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

@end

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
        NSTimer *timer = [NSTimer scheduledTimerWithTimeIntervalWrap:timeInterval block:^(NSTimer * _Nonnull timer) {
            if (callback != nil) {
                [callback callWithArguments:[NSArray array]];
            }
        } repeats:repeats];
        [timers setValue:timer forKey:uuid];
    });
    return uuid;
}

@end
