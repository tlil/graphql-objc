#ifndef TimerJS_h
#define TimerJS_h

@import JavaScriptCore;

#import <Foundation/Foundation.h>

@interface NSTimer (Blocks)
+(id)scheduledTimerWithTimeIntervalWrap:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
@end

@protocol TimerJSExport <JSExport>

-(NSString*)setTimeout:(JSValue*)args;

-(NSString*)setInterval:(JSValue*)args;

-(void)clearTimeout:(JSValue*)args;

@end

@interface TimerJS : NSObject<TimerJSExport>

+(instancetype)registerInto:(JSContext*)context;

-(NSString*)createTimer:(JSValue*)callback withInterval:(double)ms andRepeats:(bool)repeats;

@end

#endif /* TimerJS_h */
