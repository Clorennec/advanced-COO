Class {
	#name : 'GridApp',
	#superclass : 'BlSpace',
	#instVars : [
		'grid'
	],
	#category : 'bloc-intro',
	#package : 'bloc-intro'
}

{ #category : 'initialization' }
GridApp >> initialize [

	super initialize.
	self useSDL2Host.
	grid := SquareGrid initializeWithGridSize: 10 squareSize: 50.
	self root addChild: grid
]

{ #category : 'instance creation' }
GridApp >> open [
	self show
]
