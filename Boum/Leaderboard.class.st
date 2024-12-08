Class {
	#name : 'Leaderboard',
	#superclass : 'Object',
	#instVars : [
		'scores',
		'filePath'
	],
	#category : 'Boum',
	#package : 'Boum'
}

{ #category : 'initialization' }
Leaderboard >> addScore: aPlayerName withPoints: points [
	| newEntry |
	newEntry := { 
		'name' -> aPlayerName. 
		'score' -> points.
		'date' -> Date today asString 
	} asDictionary.
	
	scores add: newEntry.
	scores := scores 
		sortUsing: [ :a :b | (a at: 'score') > (b at: 'score') ].

	scores := scores first: (scores size min: 10).

	self saveScores
]

{ #category : 'initialization' }
Leaderboard >> initialize [
	super initialize.
	scores := OrderedCollection new.
	filePath := FileSystem workingDirectory / 'boum_leaderboard.ston'
]

{ #category : 'initialization' }
Leaderboard >> loadScores [

	filePath exists ifTrue: [
		| loadedScores |
		[
			loadedScores := STON fromString: filePath contents.
			scores := loadedScores asOrderedCollection.
			scores := scores 
				sortUsing: [ :a :b | (a at: 'score') > (b at: 'score') ].
			scores := scores first: (scores size min: 10)
		] on: Error do: [ :ex | 
			scores := OrderedCollection new
		]
	]
]

{ #category : 'initialization' }
Leaderboard >> saveScores [
	| ston |
	ston := STON toStringPretty: scores.
	filePath writeStreamDo: [ :stream |
		stream nextPutAll: ston]
]
