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

	self explode
]

{ #category : 'initialization' }
Projectile >> initialize [

	super initialize.
	sprite := ProjectileSprite images.
	blElement background: (ProjectileSprite imageAt: currentFrame).
	blElement extent: ProjectileSprite extent.
	self velocity: 0 @ -12
]

{ #category : 'initialization' }
Projectile >> initializeWithPosition: aPosition [

	self initialize.
	self currentPosition: aPosition.
	^ self
]

{ #category : 'updating' }
Projectile >> update [

	self move
]
