//
//  EffectsProcessor.m
//  AudioKit Example
//
//  Created by Aurelius Prochazka on 6/9/12.
//  Copyright (c) 2012 Aurelius Prochazka. All rights reserved.
//

#import "EffectsProcessor.h"

@implementation EffectsProcessor

- (instancetype)initWithAudioSource:(AKAudio *)audioSource
{
    self = [super init];
    if (self) {
        
        // INSTRUMENT CONTROL ==================================================
        _reverb  = [[AKInstrumentProperty alloc] initWithValue:0.0
                                                       minimum:0.0
                                                       maximum:1.0];
        
        // INSTRUMENT DEFINITION ===============================================
        
        AKReverb *reverb = [[AKReverb alloc] initWithInput:audioSource];
        reverb.feedback = _reverb;
        
        AKMix *leftMix = [[AKMix alloc] initWithInput1:reverb.leftOutput
                                                input2:audioSource
                                                balance:akp(0.5)];
        
        AKMix *rightMix = [[AKMix alloc] initWithInput1:reverb.rightOutput
                                                 input2:audioSource
                                                 balance:akp(0.5)];
        
        // AUDIO OUTPUT ========================================================
        
        AKAudioOutput *audio;
        audio = [[AKAudioOutput alloc] initWithLeftAudio:leftMix rightAudio:rightMix];
        
        // RESET INPUTS ========================================================
        [self resetParameter:audioSource];
    }
    return self;
}

@end
