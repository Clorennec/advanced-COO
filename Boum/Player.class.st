Class {
	#name : 'Player',
	#superclass : 'GameObject',
	#instVars : [
		'cooldown',
		'cannonPositions'
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
	self takeDamage.
	
	
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
	cannonPositions := (SpaceshipSprite spaceshipConfigurations at: aType) at: 'cannonPositions'.
	blElement background: (sprite at: currentFrame).
	blElement extent: (sprite at: currentFrame) extent.
	cooldown := false.
	^ self
]

{ #category : 'game controls' }
Player >> shoot [

	| projectiles |
	projectiles := OrderedCollection new.
	cannonPositions do: [ :pos |
		projectiles add:
			(Projectile new initializeWithPosition: self currentPosition + pos) ].
	^ projectiles
]

{ #category : 'as yet unclassified' }
Player >> takeDamage [
	

	
]
