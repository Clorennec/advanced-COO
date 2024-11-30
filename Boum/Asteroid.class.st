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
	sprite := ExplosionSprite uniqueInstance images.
	currentFrame := 1.
	blElement background: (sprite at: 1).
	self currentPosition:
		pos - ((sprite at: currentFrame) extent - blElement extent / 2).
	blElement extent: (sprite at: currentFrame) extent
]

{ #category : 'initialization' }
Asteroid >> initialize [

	super initialize.
	sprite := AsteroidSprite uniqueInstance images.
	blElement background: (sprite at: currentFrame).
	blElement extent: 102@102.
]
