//
//  AdditionalInformation.m
//
//  Created by hu  on 15/5/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AdditionalInformation.h"


NSString *const kAdditionalInformationTelephone = @"telephone";
NSString *const kAdditionalInformationName = @"name";
NSString *const kAdditionalInformationTag = @"tag";
NSString *const kAdditionalInformationAddress = @"address";


@interface AdditionalInformation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AdditionalInformation

@synthesize telephone = _telephone;
@synthesize name = _name;
@synthesize tag = _tag;
@synthesize address = _address;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.telephone = [self objectOrNilForKey:kAdditionalInformationTelephone fromDictionary:dict];
            self.name = [self objectOrNilForKey:kAdditionalInformationName fromDictionary:dict];
            self.tag = [self objectOrNilForKey:kAdditionalInformationTag fromDictionary:dict];
            self.address = [self objectOrNilForKey:kAdditionalInformationAddress fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.telephone forKey:kAdditionalInformationTelephone];
    [mutableDict setValue:self.name forKey:kAdditionalInformationName];
    [mutableDict setValue:self.tag forKey:kAdditionalInformationTag];
    [mutableDict setValue:self.address forKey:kAdditionalInformationAddress];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.telephone = [aDecoder decodeObjectForKey:kAdditionalInformationTelephone];
    self.name = [aDecoder decodeObjectForKey:kAdditionalInformationName];
    self.tag = [aDecoder decodeObjectForKey:kAdditionalInformationTag];
    self.address = [aDecoder decodeObjectForKey:kAdditionalInformationAddress];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_telephone forKey:kAdditionalInformationTelephone];
    [aCoder encodeObject:_name forKey:kAdditionalInformationName];
    [aCoder encodeObject:_tag forKey:kAdditionalInformationTag];
    [aCoder encodeObject:_address forKey:kAdditionalInformationAddress];
}

- (id)copyWithZone:(NSZone *)zone
{
    AdditionalInformation *copy = [[AdditionalInformation alloc] init];
    
    if (copy) {

        copy.telephone = [self.telephone copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
    }
    
    return copy;
}


@end
