Class {
	#name : 'SquareGrid',
	#superclass : 'BlElement',
	#instVars : [
		'gridSize',
		'squareSize',
		'padding',
		'squares'
	],
	#category : 'bloc-intro',
	#package : 'bloc-intro'
}

{ #category : 'initialization' }
SquareGrid class >> initializeWithGridSize: gridSize squareSize: squareSize [

	| grid |
	grid := self new.
	grid gridSize: gridSize.
	grid squareSize: squareSize.
	^ grid
]

{ #category : 'as yet unclassified' }
SquareGrid >> fillGrid [

	1 to: gridSize do: [ :i |
		1 to: gridSize do: [ :j |
			| square |
			square := ColoredSquare newWithSize: squareSize.
			square translateBy: i - 1 * squareSize @ (j - 1 * squareSize).
			self addChild: square ] ]
]

{ #category : 'accessing' }
SquareGrid >> gridSize [

	^gridSize
]

{ #category : 'accessing' }
SquareGrid >> gridSize: aSize [

	gridSize := aSize
]

{ #category : 'accessing' }
SquareGrid >> squareSize: aSize [
	squareSize := aSize 
]
