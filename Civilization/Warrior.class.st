Class {
	#name : 'Warrior',
	#superclass : 'Unit',
	#category : 'Civilization-unit',
	#package : 'Civilization',
	#tag : 'unit'
}

{ #category : 'as yet unclassified' }
Warrior >> attack: anUnit [

	hp := hp - (anUnit defendAgainstWarrior: self)
]

{ #category : 'initialization' }
Warrior >> initialize [ 
	super initialize.
	ap := 10.
	dp := 10.
]
