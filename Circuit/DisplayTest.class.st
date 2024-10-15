Class {
	#name : 'DisplayTest',
	#superclass : 'TestCase',
	#category : 'Circuit',
	#package : 'Circuit'
}

{ #category : 'tests' }
DisplayTest >> testDisplayWithInput [

	| display source |
	display := Display new.
	source := Source new.
	source on.

	display input: source.

	"Test que la valeur du Display correspond à celle du HighSignal"
	self assert: display state class equals: HighSignal. "Display connecté à HighSignal"

	"Test l'affichage de l'état"
	Transcript
		show: (display asString);
		cr
]

{ #category : 'tests' }
DisplayTest >> testDisplayWithoutInput [

	| display |
	display := Display new.

	"Test que la valeur du Display est 0 lorsqu'il n'est pas connecté"
	self assert: display state class equals: LowSignal. "Display sans connexion"

	"Test l'affichage de l'état"
	Transcript
		show: display asString;
		cr
]
