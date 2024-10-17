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
	grid extent: gridSize * squareSize @ (gridSize * squareSize).
	grid gridSize: gridSize.
	grid squareSize: squareSize.
	grid fillGrid.
	^ grid
]

{ #category : 'as yet unclassified' }
SquareGrid >> fillGrid [

	| list circle|
	list := OrderedCollection new.
	1 to: gridSize do: [ :i |
		1 to: gridSize do: [ :j |
			| square |
			square := ColoredSquare newWithSize: squareSize.
			square position: i - 1 * squareSize @ (j - 1 * squareSize).
			circle := GlowingCircle newWithSize: squareSize / 2.
         circle position: (squareSize / 4) @ (squareSize / 4). 
         square addChild: circle.
			list add: square 
	] ].
	self addChildren: list
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
