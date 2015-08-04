//
//  Data.h

#import <Foundation/Foundation.h>

@interface Campaign_Data : NSObject

@property (nonatomic, retain) NSString *id, *account_id, *name, *code, *image, *date_from, *date_to, *save_during_campaign, *created_at, *updated_at, *create_by, *update_by;

@end

@interface Question : NSObject

@property (nonatomic, retain) NSString *id, *create_by, *update_by, *section_id, *campaign_id, *kind_id, *is_mandatory, *question_lbl, *sort_order, *max_allowed_answers, *multi_ans_type, *min_scale, *max_scale, *scale_steps, *step_size, *left_slide_lbl, *right_slide_lbl, *element_status, *created_at, *updated_at;
@property (nonatomic, retain) NSString *answer;
@property (nonatomic, retain) NSMutableArray *marrAns;
@end

@interface Section_Data : NSObject

@property (nonatomic, retain) NSString *id, *account_id, *title, *image, *movie, *time_out, *youtube_url, *sort_order, *created_at, *updated_at, *campaign_id, *create_by, *update_by;
@property (nonatomic, retain) NSMutableArray *questions;
@end

@interface Data : NSObject

@property (nonatomic, retain) Campaign_Data *campaign_data;
@property (nonatomic, retain) NSMutableArray *section_data;

-(id)initWithDictionary:(NSDictionary *)dict;
@end

static inline BOOL isEmpty1(id thing)
{
    if (thing == nil)
    {
        return YES;
    }
    else if ([thing isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if ([thing isKindOfClass:[NSData class]])
    {
        if ([(NSData *)thing length] == 0)
        {
            return YES;
        }
    }
    else if ([thing isKindOfClass:[NSArray class]])
    {
        if ([(NSArray *)thing copy] == 0)
        {
            return YES;
        }else if ([(NSArray *)thing count] == 0){
            return YES;
        }
    }
    else if ([thing isKindOfClass:[NSString class]])
    {
        if ([[(NSString *)thing stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
        {
            return YES;
        }else if ([(NSString *)thing isEqualToString:@"<null>"]){
            return YES;
        }
    }
    return NO;
}
