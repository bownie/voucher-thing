//
//  CustomerData.m
//  Voucher Thing
//
//  Created by Richard Bown on 14/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import "CustomerData.h"

//Customer Data
@implementation CustomerData

@synthesize m_forename, m_familyname, m_age, m_email, m_postcode, m_sex, m_town;

static CustomerData *instance = nil;
+(CustomerData *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [CustomerData new];
        }
    }
    return instance;
}

#pragma mark NSCoding

// Encode this object
//
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:m_forename forKey:forenameKey];
    [encoder encodeObject:m_familyname forKey:familyNameKey];
    [encoder encodeObject:m_email forKey:emailKey];
    [encoder encodeObject:m_sex forKey:sexKey];
    [encoder encodeObject:m_age forKey:ageKey];
    [encoder encodeObject:m_town forKey:townKey];
    [encoder encodeObject:m_postcode forKey:postcodeKey];

}

// Decode this object
//
- (id)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    
    self.m_forename = [decoder decodeObjectForKey:forenameKey];
    self.m_familyname = [decoder decodeObjectForKey:familyNameKey];
    self.m_email = [decoder decodeObjectForKey:emailKey];
    self.m_sex = [decoder decodeObjectForKey:sexKey];
    self.m_age = [decoder decodeObjectForKey:ageKey];
    self.m_town = [decoder decodeObjectForKey:townKey];
    self.m_postcode = [decoder decodeObjectForKey:postcodeKey];
    
    return self;
}

@end
