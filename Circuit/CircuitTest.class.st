Class {
	#name : 'CircuitTest',
	#superclass : 'TestCase',
	#category : 'Circuit',
	#package : 'Circuit'
}

{ #category : 'tests' }
CircuitTest >> testAndGate [

	| andGate high low |
	andGate := And new.
	high := Source new.
	low := Source new.
	low off.

	andGate firstInput: high.
	andGate secondInput: low.

	self assert: andGate state value equals: 0. 

]

{ #category : 'tests' }
CircuitTest >> testCircuit [

	| source1 source2 sourceSecurity or not and fan |
	source1 := Source new.
	source2 := Source new.
	sourceSecurity := Source new.
	or := Or new.
	not := Not new.
	and := And new.
	fan := Fan new.
	or firstInput: source1.
	or secondInput: source2.
	not input: sourceSecurity.
	and firstInput: or.
	and secondInput: not.
	fan input: and.

	source1 on.
	source2 off.
	sourceSecurity on.

	self assert: fan state class equals: LowSignal
	
	
]

{ #category : 'tests' }
CircuitTest >> testCircuitComponents [

	| source1 source2 source3 andGate orGate notGate circuit fan |
	"Initialiser les signaux (sources)"
	source1 := Source new.
	source2 := Source new.
	source3 := Source new off.

	"Créer les portes logiques"
	andGate := And new.
	orGate := Or new.
	notGate := Not new.

	"Connecter les signaux aux portes"
	andGate firstInput: source1.
	andGate secondInput: source2. "AND entre signal1 et signal2"

	notGate input: source3. "NOT sur signal3"

	orGate firstInput: andGate.
	orGate secondInput: notGate. "OR entre la sortie de AND et la sortie de NOT"

	"Créer un Display pour la sortie finale"
	fan := Fan new.
	fan input: orGate.

	"Créer le circuit à partir de la sortie de la porte OR"
	circuit := Circuit new.
	circuit fromOutput: fan.

	"Vérifier que tous les composants du circuit sont présents"
	self assert: (circuit components includes: source1).
	self assert: (circuit components includes: source2).
	self assert: (circuit components includes: source3).
	self assert: (circuit components includes: andGate).
	self assert: (circuit components includes: orGate).
	self assert: (circuit components includes: notGate).
	self assert: (circuit components includes: fan)
]

{ #category : 'tests' }
CircuitTest >> testNotOnOn [
| sourceSecurity not |
sourceSecurity := Source new.
not := Not new.
not input: sourceSecurity.
sourceSecurity on.
self assert: not state value equals: 0.

]

{ #category : 'tests' }
CircuitTest >> testSourceIsOnByDefault [
| sourceSecurity |
sourceSecurity := Source new.
self assert: sourceSecurity state value equals: 1.

]
