Class {
	#name : 'Player',
	#superclass : 'GameObject',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'instance creation' }
Player class >> newType: aType color: aColor [
        ^self basicNew initializeWithType: aType color: aColor
]

{ #category : 'initialization' }
Player >> initializeWithType: aType color: aColor [

	super initialize.
	sprite := (SpaceshipSprite type: aType color: aColor) images.
	blElement background: (sprite at: currentFrame).
	blElement extent: ((sprite at: currentFrame) extent).
	^ self 
]
