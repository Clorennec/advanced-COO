Class {
	#name : 'Asteroid',
	#superclass : 'GameObject',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'as yet unclassified' }
Asteroid >> collideWith: anObject [

	anObject collideWithAsteroid
]

{ #category : 'as yet unclassified' }
Asteroid >> collideWithAsteroid [

]

{ #category : 'as yet unclassified' }
Asteroid >> collideWithPlayer: aPlayer [
	self explode.
	aPlayer collideWithAsteroid.

	
]

{ #category : 'as yet unclassified' }
Asteroid >> collideWithProjectile: aProjectile [

	self explode.
	aProjectile collideWithAsteroid
]

{ #category : 'initialization' }
Asteroid >> initialize [

	super initialize.
	sprite := AsteroidSprite uniqueInstance images.
	blElement background: (sprite at: currentFrame).
	blElement extent: 102@102.
]
