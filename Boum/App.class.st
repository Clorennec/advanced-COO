Class {
	#name : 'App',
	#superclass : 'Object',
	#instVars : [
		'animation',
		'asteroidCreationProcess'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'adding' }
App >> addAsteroid [
	| asteroid |
	asteroid := Asteroid new.
	asteroid position: self generateOffScreenPosition.
	animation space root addChild: asteroid.
	asteroid startAnimation
]

{ #category : 'as yet unclassified' }
App >> createRandomAsteroid [
	| newAsteroid startPosition direction speed |
	newAsteroid := Asteroid new.

	"Positionner l'astéroïde en dehors de l'écran (par exemple, au hasard autour des bords)"
	startPosition := self randomPositionOutsideScreen.
	newAsteroid position: startPosition.

	"Choisir une direction et une vitesse aléatoires"
	direction := (0 to: 360) atRandom degreesToRadians.
	speed := (1 to: 5) atRandom.
	newAsteroid direction: direction.
	newAsteroid speed: speed.

	"Ajouter à l'animation et à l'espace"
	animation addAsteroid: newAsteroid.
	animation space root addChild: newAsteroid.

	newAsteroid startAnimation
]

{ #category : 'as yet unclassified' }
App >> generateOffScreenPosition [

	| screenBounds randPosition side |
	screenBounds := animation space root boundsInSpace.
	side := #( top right bottom left ) atRandom. "Choisir un côté aléatoire de l'écran"
	randPosition := side caseOf: {
			                ([ #top ]
			                 -> [ (0 to: screenBounds x) atRandom @ -100 ]).
			                ([ #right ]
			                 -> [
			                 screenBounds x + 100
			                 @ (0 to: screenBounds y) atRandom ]).
			                ([ #bottom ]
			                 -> [
			                 (0 to: screenBounds x) atRandom @ screenBounds y
			                 + 100 ]).
			                ([ #left ]
			                 -> [ -100 @ (0 to: screenBounds y) atRandom ]) }.
	^ randPosition
]

{ #category : 'as yet unclassified' }
App >> randomPositionOutsideScreen [
	| screenWidth screenHeight side randomPosition |
	screenWidth := animation space root extent x.
	screenHeight := animation space root extent y.
	side := (1 to: 4) atRandom.

	side = 1 ifTrue: [ randomPosition := (-50)@(1 to: screenHeight) atRandom ].
	side = 2 ifTrue: [ randomPosition := (screenWidth + 50)@(1 to: screenHeight) atRandom ].
	side = 3 ifTrue: [ randomPosition := (1 to: screenWidth) atRandom@(-50) ].
	side = 4 ifTrue: [ randomPosition := (1 to: screenWidth) atRandom@(screenHeight + 50) ].

	^ randomPosition
]

{ #category : 'running' }
App >> run [

	| ast1 ast2 |
	animation := Animation new.

	ast1 := Asteroid new.
	ast2 := Asteroid new.
	ast2 position: 50 @ 50.

	animation addAsteroid: ast1.
	animation addAsteroid: ast2.

	animation space root addChild: ast1.
	animation space root addChild: ast2.

	ast1 startAnimation.
	ast2 startAnimation.

	asteroidCreationProcess := [
	                           [ true ] whileTrue: [ "Attendre un délai aléatoire entre 1 et 5 secondes"
		                           (1000 to: 5000) atRandom milliSeconds
			                           wait.
		                           self createRandomAsteroid ] ] fork.

	animation start.
	animation space show
]

{ #category : 'running' }
App >> stop [

	animation stop
]
