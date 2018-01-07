

#import <Foundation/Foundation.h>

@class MCPeerID;

// Enumeration of transcript directions
typedef enum {
    TRANSCRIPT_DIRECTION_SEND = 0,
    TRANSCRIPT_DIRECTION_RECEIVE,
    TRANSCRIPT_DIRECTION_LOCAL // for admin messages. i.e. "<name> connected"
} TranscriptDirection;

@interface Transcript : NSObject

// Direction of the transcript
@property (readonly, nonatomic) TranscriptDirection direction;
// PeerID of the sender
@property (readonly, nonatomic) MCPeerID *peerID;
// String message (optional)
@property (readonly, nonatomic) NSString *message;
// Resource Image name (optional)
@property (readonly, nonatomic) NSString *imageName;
// Resource Image URL (optional)
@property (readonly, nonatomic) NSURL *imageUrl;
// Resource name (optional)
@property (readonly, nonatomic) NSProgress *progress;

// Initializer used for sent/received text messages
- (id)initWithPeerID:(MCPeerID *)peerID message:(NSString *)message direction:(TranscriptDirection)direction;
// Initializer used for sent/received image resources
- (id)initWithPeerID:(MCPeerID *)peerID imageUrl:(NSURL *)imageUrl direction:(TranscriptDirection)direction;
// Initialized used for sending/receiving image resources.  This tracks their progress
- (id)initWithPeerID:(MCPeerID *)peerID imageName:(NSString *)imageName progress:(NSProgress *)progress direction:(TranscriptDirection)direction;

@end
