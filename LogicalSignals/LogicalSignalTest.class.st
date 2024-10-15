Class {
	#name : 'LogicalSignalTest',
	#superclass : 'TestCase',
	#category : 'LogicalSignals',
	#package : 'LogicalSignals'
}

{ #category : 'tests' }
LogicalSignalTest >> testHighSignal [

	| highSignal |
	highSignal := HighSignal new.

	"Test the value of HighSignal"
	self assert: highSignal value equals: 1.

	"Test the negation of HighSignal"
	self assert: highSignal not value equals: 0.

	"Test HighSignal AND LowSignal"
	self assert: (highSignal and: LowSignal new) value equals: 0.

	"Test HighSignal OR LowSignal"
	self assert: (highSignal or: LowSignal new) value equals: 1
]

{ #category : 'tests' }
LogicalSignalTest >> testLowSignal [

	| lowSignal |
	lowSignal := LowSignal new.

	"Test the value of LowSignal"
	self assert: lowSignal value equals: 0.
	self assert: lowSignal not value equals: 1.

	"Test LowSignal AND HighSignal"
	self assert: (lowSignal and: HighSignal new) value equals: 0.

	"Test LowSignal OR HighSignal"
	self assert: (lowSignal or: HighSignal new) value equals: 1
]
