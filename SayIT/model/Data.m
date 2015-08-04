//
//  Data.m

#import "Data.h"

@implementation Question

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    NSArray *arrKeys = [dict allKeys];
    
    for (NSString *key in arrKeys)
    {
        NSString *propertyName = key;
        id obj = [dict valueForKey:key];
        @try
        {
            if([self respondsToSelector:NSSelectorFromString(propertyName)])
            {
                if (!isEmpty1(obj))
                {
                    if ([obj isKindOfClass:[NSArray class]])
                    {
                        [self setValue:obj forKey:propertyName];
                    }else{
                        [self setValue:[NSString stringWithFormat:@"%@",obj] forKey:propertyName];
                    }
                }
            }
        }
        @catch (NSException *exception)
        {
            
        }
    }
    
    return self;
}

@end
@implementation Campaign_Data

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    NSArray *arrKeys = [dict allKeys];
    
    for (NSString *key in arrKeys)
    {
        NSString *propertyName = key;
        id obj = [dict valueForKey:key];
        @try
        {
            if([self respondsToSelector:NSSelectorFromString(propertyName)])
            {
                if (!isEmpty1(obj))
                {
                    if ([obj isKindOfClass:[NSArray class]])
                    {
                        [self setValue:obj forKey:propertyName];
                    }else{
                        [self setValue:[NSString stringWithFormat:@"%@",obj] forKey:propertyName];
                    }
                }
            }
        }
        @catch (NSException *exception)
        {
            
        }
    }
    
    return self;
}

@end

@implementation Section_Data

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    NSArray *arrKeys = [dict allKeys];
    
    for (NSString *key in arrKeys)
    {
        NSString *propertyName = key;
        id obj = [dict valueForKey:key];
        @try
        {
            if([self respondsToSelector:NSSelectorFromString(propertyName)])
            {
                if (!isEmpty1(obj))
                {
                    if ([key isEqualToString:@"questions"] && [obj isKindOfClass:[NSArray class]])
                    {
                        self.questions = [[NSMutableArray alloc] init];
                        for (NSDictionary *d in obj)
                        {
                            Question *quest = [[Question alloc] initWithDictionary:d];
                            [self.questions addObject:quest];
                        }
                    }
                    else
                    {
                        [self setValue:[NSString stringWithFormat:@"%@",obj] forKey:propertyName];
                    }
                }
            }
        }
        @catch (NSException *exception)
        {
            
        }
    }
    
    return self;
}

@end

@implementation Data


-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    NSArray *arrKeys = [dict allKeys];
    
    for (NSString *key in arrKeys)
    {
        NSString *propertyName = key;
        id obj = [dict valueForKey:key];
        @try
        {
            if([self respondsToSelector:NSSelectorFromString(propertyName)])
            {
                if (!isEmpty1(obj))
                {
                    if ([key isEqualToString:@"section_data"] && [obj isKindOfClass:[NSArray class]])
                    {
                        self.section_data = [[NSMutableArray alloc] init];
                        for (NSDictionary *d in obj)
                        {
                            Section_Data *section = [[Section_Data alloc] initWithDictionary:d];
                            [self.section_data addObject:section];
                        }
                    }
                    else if ([key isEqualToString:@"campaign_data"] && [obj isKindOfClass:[NSDictionary class]])
                    {
                        self.campaign_data = [[Campaign_Data alloc] initWithDictionary:obj];
                    }
                    else
                    {
                        [self setValue:[NSString stringWithFormat:@"%@",obj] forKey:propertyName];
                    }
                }
            }
        }
        @catch (NSException *exception)
        {
            
        }
    }
    
    return self;
}

@end

