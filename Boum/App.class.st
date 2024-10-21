Class {
	#name : 'App',
	#superclass : 'Object',
	#instVars : [
		'animation',
		'space'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'running' }
App >> run [

	| ast1 ast2 |
	space := BlSpace new.
	animation := Animation new.

	ast1 := Asteroid new.
	ast2 := Asteroid new.
	ast2 position: 50@50.
	
	animation addAsteroid: ast1. 
	animation addAsteroid: ast2.
	
	space root addChild: ast1.
	space root addChild: ast2.
	
	ast1 startAnimation.
	ast2 startAnimation.

	animation start.
	space show
]

{ #category : 'running' }
App >> stop [

	animation stop
]
