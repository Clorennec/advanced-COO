Class {
	#name : 'Player',
	#superclass : 'GameObject',
	#instVars : [
		'pressedKeys'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'instance creation' }
Player class >> newType: aType color: aColor [
        ^self basicNew initializeWithType: aType color: aColor
]

{ #category : 'as yet unclassified' }
Player >> adjustVelocity [

	| newVelocity speedIncrement |
	speedIncrement := 0.1.

	newVelocity := velocityVector.

	pressedKeys do: [ :key |
		key
			caseOf: {
					([ #up ]
					 -> [ newVelocity := newVelocity + (0 @ (0 - speedIncrement)) ]).
					([ #down ]
					 -> [ newVelocity := newVelocity + (0 @ speedIncrement) ]).
					([ #left ]
					 -> [ newVelocity := newVelocity + (0 - speedIncrement @ 0) ]).
					([ #right ]
					 -> [ newVelocity := newVelocity + (speedIncrement @ 0) ]) }
			otherwise: [  ] ].

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
Player >> initializeWithType: aType color: aColor [

	super initialize.
	pressedKeys := Set new.
	sprite := (SpaceshipSprite type: aType color: aColor) images.
	blElement background: (sprite at: currentFrame).
	blElement extent: (sprite at: currentFrame) extent.
	blElement
            addEventHandlerOn: BlKeyDownEvent
            do: [ :event | self keyDown: event key ].
        blElement
            addEventHandlerOn: BlKeyUpEvent
            do: [ :event | self keyUp: event key ].
	^ self
]

{ #category : 'initialization' }
Player >> keyDown: aKey [
        pressedKeys add: aKey name.
]

{ #category : 'as yet unclassified' }
Player >> keyUp: aKey [
        pressedKeys remove: aKey name.
]

{ #category : 'as yet unclassified' }
Player >> takeDamage [
	

	
]

{ #category : 'updating' }
Player >> update [ 
	super update.
	self adjustVelocity.
]
