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
    self assert: (highSignal value = 1).

    "Test the negation of HighSignal"
    self assert: (highSignal not value = 0).

    "Test HighSignal AND LowSignal"
    self assert: ((highSignal and: (LowSignal new)) value = 0).

    "Test HighSignal OR LowSignal"
    self assert: ((highSignal or: (LowSignal new)) value = 1).
]
