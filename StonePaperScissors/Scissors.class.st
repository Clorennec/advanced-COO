Class {
	#name : 'Scissors',
	#superclass : 'Object',
	#category : 'StonePaperScissors',
	#package : 'StonePaperScissors'
}

{ #category : 'as yet unclassified' }
Scissors >> playAgainstPaper [ 
	^'Scissors'
]

{ #category : 'as yet unclassified' }
Scissors >> playAgainstScissors [
	^'Draw'
]

{ #category : 'as yet unclassified' }
Scissors >> playAgainstStone [ 
	^'Stone'
]

{ #category : 'as yet unclassified' }
Scissors >> vs: anElement [
	^ anElement playAgainstScissors
]
