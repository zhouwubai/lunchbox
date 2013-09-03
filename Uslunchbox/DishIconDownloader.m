//
//  DishIconDownloader.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/2/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "DishIconDownloader.h"
#import "Dish.h"

#define kDishIconSize 48


@interface DishIconDownloader()

@property (nonatomic,strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;

@end


@implementation DishIconDownloader


#pragma mark

-(void)startDownload
{
    self.activeDownload = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self dish] buildImageUrl]]];
    
    //alloc + init and start an NSURLConnection; release on completion/failure
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.imageConnection = conn;
    
}


-(void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}




#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.activeDownload = nil;
    
    self.imageConnection = nil;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    
    if(image.size.width != kDishIconSize || image.size.height != kDishIconSize)
    {
        CGSize itemSize = CGSizeMake(kDishIconSize, kDishIconSize);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0f);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [image drawInRect:imageRect];
        self.dish.dishIcon = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        self.dish.dishIcon = image;
    }
    
    self.activeDownload = nil;
    self.imageConnection = nil;
    
    
    //call our delegate and tell it that our icon is ready for display
    if(self.completionHandler)
        self.completionHandler();
    
}

















@end
