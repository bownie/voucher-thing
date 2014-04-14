//
//  CustomerData.h
//  Voucher Thing
//
//  Created by Richard Bown on 14/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CustomerData : NSObject<NSCoding> {
    
    NSString *m_forename;
    NSString *m_familyname;
    NSString *m_email;
    NSString *m_sex;
    NSString *m_age;
    NSString *m_town;
    NSString *m_postcode;
    
    // Inside @interface
    NSString *m_docPath;
    
    NSData *m_data;

}

// Attributes
//
@property(nonatomic,retain)NSString *m_forename;
@property(nonatomic,retain)NSString *m_familyname;
@property(nonatomic,retain)NSString *m_email;
@property(nonatomic,retain)NSString *m_sex;
@property(nonatomic,retain)NSString *m_age;
@property(nonatomic,retain)NSString *m_town;
@property(nonatomic,retain)NSString *m_postcode;

#define forenameKey @"Forename"
#define familyNameKey @"Familyname"
#define emailKey @"email"
#define sexKey @"sex"
#define ageKey @"age"
#define townKey @"town"
#define postcodeKey @"postcode"

+(CustomerData*)getInstance;

// After @interface
@property (copy) NSString *m_docPath;
@property (copy) NSData *m_data;

- (id)init;
- (id)initWithDocPath:(NSString *)m_docPath;
- (void)saveData;
- (void)loadData;
- (void)deleteDoc;
- (NSString*) getPrivateDocsDir;


@end

