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
DiceHandle >> + aDiceHandle [

	| newHandle |
	newHandle := DiceHandle new.
	dices do: [ :eachDice | newHandle addDice: eachDice ].
	aDiceHandle dices do: [ :eachDice | newHandle addDice: eachDice ].
	^ newHandle
]

{ #category : 'adding' }
DiceHandle >> addDice: aDice [
	dices add: aDice.
]

{ #category : 'as yet unclassified' }
DiceHandle >> diceNumber [
	^dices size
]

{ #category : 'accessing' }
DiceHandle >> dices [
	^dices 
]

{ #category : 'initialization' }
DiceHandle >> initialize [
    dices := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
DiceHandle >> roll [
    | total |
    total := 0.
    

    dices do: [ :eachDice | total := total + eachDice roll ].
    
    ^ total.
]
