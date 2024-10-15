Class {
	#name : 'DiceHandle',
	#superclass : 'Object',
	#instVars : [
		'dices'
	],
	#category : 'Dice',
	#package : 'Dice'
}

{ #category : 'arithmetic' }
DiceHandle >> + aDicable [

	^ aDicable addWithHandle: self
]

{ #category : 'adding' }
DiceHandle >> addDice: aDice [
	dices add: aDice.
]

{ #category : 'adding' }
DiceHandle >> addWithDice: aDice [
	^ self addDice: aDice 
	
]

{ #category : 'adding' }
DiceHandle >> addWithHandle: aHandle [
	aHandle dices do: [ :eachDice | 
		self addDice: eachDice ].
	^ self
]

{ #category : 'as yet unclassified' }
DiceHandle >> diceNumber [
	^dices size
]

{ #category : 'accessing' }
DiceHandle >> dices [
	^dices 
]

{ #category : 'accessing' }
DiceHandle >> faces [

	^ dices sum: [ :eachDice | eachDice faces ]
]

{ #category : 'initialization' }
DiceHandle >> initialize [
    dices := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
DiceHandle >> roll [
	^dices sum: [ :eachDice | eachDice roll ].

]
