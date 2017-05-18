#ifndef TimerJS_h
#define TimerJS_h

@import JavaScriptCore;

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
