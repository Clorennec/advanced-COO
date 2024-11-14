Class {
	#name : 'Projectile',
	#superclass : 'GameObject',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'initialization' }
Projectile >> initialize [

	super initialize.
	sprite := ProjectileSprite uniqueInstance images.
	blElement background: (sprite at: currentFrame).
	blElement extent: (sprite at: currentFrame) extent
]

{ #category : 'initialization' }
Projectile >> initializeWithPosition: aPosition [

	self initialize.
	self currentPosition: aPosition.
	self velocity: 0 @ -12.
]

{ #category : 'updating' }
Projectile >> update [ 
	self currentPosition: currentPosition + velocityVector 
]
