Class {
	#name : 'Stone',
	#superclass : 'Object',
	#category : 'StonePaperScissors',
	#package : 'StonePaperScissors'
}

{ #category : 'as yet unclassified' }
Stone >> playAgainstPaper [
	^'Paper'
]

{ #category : 'as yet unclassified' }
Stone >> playAgainstScissors [ 
	^'Stone'
]

{ #category : 'as yet unclassified' }
Stone >> playAgainstStone [ 
	^'Draw'
]

{ #category : 'as yet unclassified' }
Stone >> vs: anElement [
	^ anElement playAgainstStone 
]
