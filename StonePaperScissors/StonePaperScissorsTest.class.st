Class {
	#name : 'StonePaperScissorsTest',
	#superclass : 'TestCase',
	#category : 'StonePaperScissors',
	#package : 'StonePaperScissors'
}

{ #category : 'running' }
StonePaperScissorsTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
]

{ #category : 'tests' }
StonePaperScissorsTest >> testPaperAgainstPaper [

	self assert: (Paper new vs: Paper new) equals: #Draw
]

{ #category : 'tests' }
StonePaperScissorsTest >> testPaperAgainstScissorsIsWinning [

	self assert: (Paper new vs: Scissors new) equals: #Scissors
]

{ #category : 'tests' }
StonePaperScissorsTest >> testPaperAgainstStoneIsWinning [

	self assert: (Paper new vs: Stone new) equals: #Paper
]

{ #category : 'tests' }
StonePaperScissorsTest >> testScissorsAgainstPaperIsWinning [

	self assert: (Scissors new vs: Paper new) equals: #Scissors
]

{ #category : 'tests' }
StonePaperScissorsTest >> testScissorsAgainstScissors [

	self assert: (Scissors new vs: Scissors new) equals: #Draw
]

{ #category : 'tests' }
StonePaperScissorsTest >> testScissorsAgainstStoneIsWinning [

	self assert: (Scissors new vs: Stone new) equals: #Stone
]

{ #category : 'tests' }
StonePaperScissorsTest >> testStoneAgainstPaperIsWinning [

	self assert: (Stone new vs: Paper new) equals: #Paper
]

{ #category : 'tests' }
StonePaperScissorsTest >> testStoneAgainstScissorsIsWinning [

	self assert: (Stone new vs: Scissors new) equals: #Stone
]

{ #category : 'tests' }
StonePaperScissorsTest >> testStoneAgainstStone [

	self assert: (Stone new vs: Stone new) equals: #Draw
]
