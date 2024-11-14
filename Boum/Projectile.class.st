Class {
	#name : 'Projectile',
	#superclass : 'GameObject',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
Projectile >> collideWith: anObject [

	anObject collideWithProjectile: self
]

{ #category : 'as yet unclassified' }
Projectile >> collideWithAsteroid [ 
	self remove.
]

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
	^self
]

{ #category : 'as yet unclassified' }
Projectile >> remove [ 
	exploded := true.
	blElement removeFromParent.
]

{ #category : 'updating' }
Projectile >> update [ 
	self currentPosition: currentPosition + velocityVector 
]
