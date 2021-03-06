//
//  CustomerData.m
//  Voucher Thing
//
//  Created by Richard Bown on 14/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import "CustomerData.h"

#define kDataKey        @"CustomerData"
#define kDataFile       @"data.plist"

//Customer Data
//
@implementation CustomerData

@synthesize m_forename, m_familyname, m_age, m_email, m_postcode, m_sex, m_town;

static CustomerData *instance = nil;
+(CustomerData *)getInstance
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance= [CustomerData new];
        }
    }
    return instance;
}


// After @implementation
@synthesize m_docPath;
@synthesize m_data;

// Add to dealloc
//
- (void)dealloc {
    // ADC
    //
    //[m_docPath release];
    m_docPath = nil;
}


// Add new methods
- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (id)initWithDocPath:(NSString *)docPath {
    if ((self = [super init])) {
        docPath = [docPath copy];
    }
    return self;
}

- (BOOL)createDataPath {
    
    if (m_docPath == nil) {
        self.m_docPath = [self getPrivateDocsDir];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:m_docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return success;
}



- (NSString *)getPrivateDocsDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
    
}

// Override data
//
- (void)loadData {
    
    if (m_docPath == nil) {
        self.m_docPath = [self getPrivateDocsDir];
    }
    
    NSString *dataPath = [m_docPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath];
    if (codedData == nil)
    {
        NSLog(@"Got nothing to load");
        return;
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    m_data = [unarchiver decodeObjectForKey:kDataKey];
    [unarchiver finishDecoding];
    //[unarchiver release];
}

// Delete document
//
- (void)deleteDoc {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:m_docPath error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

- (void)saveData {
    
    //if (_data == nil) return;
    
    [self createDataPath];
    
    NSString *dataPath = [m_docPath stringByAppendingPathComponent:kDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:m_data forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
    //[archiver release];
    //[data release];
    
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
    //self = [self init];
    
    self = [super init];
    
    if(self)
    {
        self.m_forename = [decoder decodeObjectForKey:forenameKey];
        self.m_familyname = [decoder decodeObjectForKey:familyNameKey];
        self.m_email = [decoder decodeObjectForKey:emailKey ];
        self.m_sex = [decoder decodeObjectForKey:sexKey];
        self.m_age = [decoder decodeObjectForKey:ageKey];
        self.m_town = [decoder decodeObjectForKey:townKey];
        self.m_postcode = [decoder decodeObjectForKey:postcodeKey];
    }
    return self;
}

@end
