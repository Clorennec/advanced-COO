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

{ #category : 'as yet unclassified' }
Player >> adjustVelocityForKey: aKey [

	aKey name caseOf: {
			([ #UP ] -> [ self increaseVelocityInDirection: 0 @ -1 ]).
			([ #DOWN ] -> [ self increaseVelocityInDirection: 0 @ 1 ]).
			([ #LEFT ] -> [ self increaseVelocityInDirection: -1 @ 0 ]).
			([ #RIGHT ] -> [ self increaseVelocityInDirection: 1 @ 0 ]) }
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

{ #category : 'as yet unclassified' }
Player >> increaseVelocityInDirection: aDirection [

	| speedIncrement |
	speedIncrement := 0.1.

	"Limiter la vitesse maximale"
	((velocityVector + (aDirection * speedIncrement)) x <= 5
		and: (velocityVector + (aDirection * speedIncrement)) y <= 5)
		ifTrue: [
		velocityVector := velocityVector + (aDirection * speedIncrement) ]
]

{ #category : 'initialization' }
Player >> initializeWithType: aType color: aColor [

	super initialize.
	sprite := (SpaceshipSprite type: aType color: aColor) images.
	blElement background: (sprite at: currentFrame).
	blElement extent: (sprite at: currentFrame) extent.
	blElement
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | self adjustVelocityForKey: event key ].
	^ self
]

{ #category : 'as yet unclassified' }
Player >> takeDamage [
	

	
]
