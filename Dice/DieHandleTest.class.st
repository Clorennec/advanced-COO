Class {
	#name : 'DieHandleTest',
	#superclass : 'TestCase',
	#category : 'Dice',
	#package : 'Dice'
}

{ #category : 'tests' }
DieHandleTest >> testAddingTwiceTheSameDice [

	| handle |
	handle := DiceHandle new.
	handle addDice: (Dice withFaces: 6).
	self assert: handle diceNumber equals: 1.
	handle addDice: (Dice withFaces: 6).
	self assert: handle diceNumber equals: 2.

]

{ #category : 'tests' }
DieHandleTest >> testCreationAdding [

	| handle |
	handle := DiceHandle new
		          addDice: (Dice withFaces: 6);
		          addDice: (Dice withFaces: 10);
		          yourself.
	self assert: handle diceNumber equals: 2
]

{ #category : 'tests' }
DieHandleTest >> testRoll [

	| handle result facesSum |
	handle := DiceHandle new.
	handle addDice: (Dice withFaces: 6).
	handle addDice: (Dice withFaces: 10).

	result := handle roll.

	facesSum := 6 + 10.

	"Check that the roll result is between the minimum (2) and the maximum (16)"
	self assert: (result >= 2 and: [ result <= facesSum ])
]

{ #category : 'tests' }
DieHandleTest >> testSimpleHandle [

	self assert: 2 D20 diceNumber equals: 2
]

{ #category : 'tests' }
DieHandleTest >> testSumOfHandles [

	| hd1 hd2 hd3 |
	hd1 := DiceHandle new
		       addDice: (Dice withFaces: 20);
		       addDice: (Dice withFaces: 20);
		       yourself.
	hd2 := DiceHandle new
		       addDice: (Dice withFaces: 10);
		       addDice: (Dice withFaces: 10);
		       yourself.
	hd3 := hd1 + hd2.
	self assert: hd3 diceNumber equals: 4
]

{ #category : 'tests' }
DieHandleTest >> testSumming [
| handle |
handle := 2 D20 + 3 D10.
self assert: handle diceNumber equals: 5.
]
