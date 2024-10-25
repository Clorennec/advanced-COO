Class {
	#name : 'Asteroid',
	#superclass : 'GameObject',
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'initialization' }
Asteroid >> initialize [

	super initialize.
	sprite := AsteroidSprite uniqueInstance images.
	blElement background: (sprite at: currentFrame)
]
