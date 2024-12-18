Class {
	#name : 'WidgetTest',
	#superclass : 'TestCase',
	#category : 'WidgetTuto',
	#package : 'WidgetTuto'
}

{ #category : 'tests' }
WidgetTest >> testCallbackCallOnClick [

	| inputElem testNumberOfCall testValue |
	testNumberOfCall := 0.
	testValue := -1.
	inputElem := BlIntegerInputElement new.
	inputElem callbackBlock: [ :val |
		testNumberOfCall := testNumberOfCall + 1.
		testValue := val.
	].
	self assert: testNumberOfCall equals: 0.
	self assert: testValue equals: -1.
	BlSpace simulateClickOn: inputElem minus.
	self assert: testNumberOfCall equals: 1.
	self assert: testValue equals: 19.
	6 timesRepeat: [ BlSpace simulateClickOn: inputElem plus ].
	self assert: testNumberOfCall equals: 7.
	self assert: testValue equals: 25.
	inputElem changeValueTo: 0.
	self assert: testNumberOfCall equals: 8.
	self assert: testValue equals: 0.
	BlSpace simulateClickOn: inputElem minus.
	self assert: testNumberOfCall equals: 8.
	self assert: testValue equals: 0.
]

{ #category : 'tests' }
WidgetTest >> testCanChangeLabel [

	| inputElem |
	inputElem := BlIntegerInputElement new.
	self assert: inputElem label text asString equals: 'Input'.
	inputElem label: 'Volume'.
	self assert: inputElem label text asString equals: 'Volume'.
]

{ #category : 'tests' }
WidgetTest >> testChildrenAreSet [

	| inputElem |
	inputElem := BlIntegerInputElement new.
	self assert: inputElem children size equals: 4 
]

{ #category : 'tests' }
WidgetTest >> testValueCantBeNegative [

	| inputElem value |
	inputElem := BlIntegerInputElement new.
	inputElem changeValueTo: 0.
	BlSpace simulateClickOn: inputElem minus.
	value := inputElem value. 
	self assert: value equals: 0
]

{ #category : 'tests' }
WidgetTest >> testValueUpdatedOnClick [

	| inputElem |
	inputElem := BlIntegerInputElement new.
	BlSpace simulateClickOn: inputElem minus.
	self assert: inputElem value equals: 19.
	6 timesRepeat: [ BlSpace simulateClickOn: inputElem plus ].
	self assert: inputElem value equals: 25
]
