Class {
	#name : 'Player',
	#superclass : 'GameObject',
	#instVars : [
		'cooldown'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'instance creation' }
Player class >> newType: aType color: aColor [
        ^self basicNew initializeWithType: aType color: aColor
]

{ #category : 'as yet unclassified' }
Player >> adjustVelocity: aKey [

	| newVelocity speedIncrement |
	speedIncrement := 0.25.

	newVelocity := velocityVector.

		aKey
			caseOf: {
					([ #UP ]
					 -> [ newVelocity := newVelocity + (0 @ (0 - speedIncrement)) ]).
					([ #DOWN ]
					 -> [ newVelocity := newVelocity + (0 @ speedIncrement) ]).
					([ #LEFT ]
					 -> [ newVelocity := newVelocity + (0 - speedIncrement @ 0) ]).
					([ #RIGHT ]
					 -> [ newVelocity := newVelocity + (speedIncrement @ 0) ]) }
			otherwise: [  ].

	(newVelocity x abs <= 5 and: [ newVelocity y abs <= 5 ]) ifTrue: [
		velocityVector := newVelocity ]
]

{ #category : 'as yet unclassified' }
Player >> collideWith: anObject [

	anObject collideWithPlayer: self
]

{ #category : 'as yet unclassified' }
Player >> collideWithAsteroid [
	
]

{ #category : 'as yet unclassified' }
Player >> collideWithAsteroid: anAsteroid [
	self takeDamage.
	anAsteroid collideWithPlayer.
	

	
]

{ #category : 'initialization' }
Player >> cooldown [
	^cooldown 
]

{ #category : 'initialization' }
Player >> cooldown: aBool [
	cooldown := aBool.
]

{ #category : 'initialization' }
Player >> initializeWithType: aType color: aColor [

	super initialize.
	sprite := (SpaceshipSprite type: aType color: aColor) images.
	blElement background: (sprite at: currentFrame).
	blElement extent: (sprite at: currentFrame) extent.
	cooldown := false.
	^ self
]

{ #category : 'as yet unclassified' }
Player >> takeDamage [
	

	
]
