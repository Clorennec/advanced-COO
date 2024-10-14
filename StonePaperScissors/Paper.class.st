Class {
	#name : 'Paper',
	#superclass : 'Object',
	#category : 'StonePaperScissors',
	#package : 'StonePaperScissors'
}

{ #category : 'as yet unclassified' }
Paper >> playAgainstPaper [ 
	^'Draw'
]

{ #category : 'as yet unclassified' }
Paper >> playAgainstScissors [
	^'Scissors'
]

{ #category : 'as yet unclassified' }
Paper >> playAgainstStone [
	^'Paper'
]

{ #category : 'as yet unclassified' }
Paper >> vs: anElement [
	^ anElement playAgainstPaper
]
