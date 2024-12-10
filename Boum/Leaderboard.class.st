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
Leaderboard >> addScore: aScore playerName: aPlayerName [

    | newEntry sortedScores |
    newEntry := {
        ('name' -> aPlayerName).
        ('score' -> aScore).
        ('date' -> Date today asString)
    } asDictionary.

    scores add: newEntry.

    sortedScores := scores sort: [ :a :b |
        (a at: 'score') > (b at: 'score')
    ].

    scores := sortedScores first: (sortedScores size min: 10).

    self saveScores

]

{ #category : 'initialization' }
Leaderboard >> initialize [

	super initialize.
	scores := OrderedCollection new.
	filePath := FileSystem workingDirectory / 'pharo-local' / 'iceberg'
	            / 'Clorennec' / 'advanced-COO' / 'Boum'
	            / 'boum_leaderboard.ston'.
	self loadScores 
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

{ #category : 'accessing' }
Leaderboard >> scores [ 
	^scores 
]
