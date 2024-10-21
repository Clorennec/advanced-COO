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

{ #category : 'as yet unclassified' }
App >> createRandomAsteroid [

	| newAsteroid startPosition direction speed centerPosition deltaX deltaY |
	newAsteroid := Asteroid new.
	startPosition := self randomPositionOutsideScreen.
	centerPosition := (animation space width / 2) @ (animation space height / 2).

	deltaX := centerPosition x - startPosition x.
	deltaY := centerPosition y - startPosition y.

	direction := (deltaY / deltaX) arcTan.
	speed := (1 to: 5) atRandom.
	newAsteroid direction: direction.
	newAsteroid speed: speed.

	animation addAsteroid: newAsteroid.
	animation space root addChild: newAsteroid.
	newAsteroid position: startPosition.
	newAsteroid startAnimation
]

{ #category : 'initialization' }
App >> initialize [ 
	animation := Animation new.
	animation space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ :event | self stop ].
]

{ #category : 'as yet unclassified' }
App >> randomPositionOutsideScreen [

	| screenWidth screenHeight side randomPosition |
	screenWidth := animation space extent x.
	screenHeight := animation space extent y.
	side := (1 to: 4) atRandom.

	side = 1 ifTrue: [
		randomPosition := 0 @ (1 to: screenHeight) atRandom ].
	side = 2 ifTrue: [
		randomPosition := (screenWidth - 100) @ (1 to: screenHeight) atRandom ].
	side = 3 ifTrue: [
		randomPosition := (1 to: screenWidth) atRandom @ 0 ].
	side = 4 ifTrue: [
		randomPosition := (1 to: screenWidth) atRandom
		                  @ (screenHeight - 100) ].
	randomPosition traceCr.
	^ randomPosition
]

{ #category : 'running' }
App >> run [

	| ast1 ast2 |

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

	asteroidCreationProcess ifNotNil: [ asteroidCreationProcess terminate ].
	animation stop
]
