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

{ #category : 'as yet unclassified' }
Asteroid >> explode [

	| pos |
	super explode.
	pos := currentPosition.
	sprite := ExplosionSprite images.
	currentFrame := 1.
	blElement background: (ExplosionSprite imageAt: currentFrame).
	self currentPosition: pos - (ExplosionSprite extent - blElement extent / 2).
	blElement extent: ExplosionSprite extent
]

{ #category : 'initialization' }
Asteroid >> initialize [

	super initialize.
	sprite := AsteroidSprite images.
	blElement background: (AsteroidSprite imageAt: currentFrame).
	blElement extent: AsteroidSprite extent
]
