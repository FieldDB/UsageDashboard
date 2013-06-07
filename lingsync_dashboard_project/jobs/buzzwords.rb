# :first_in sets how long it takes before the job is first run. In this case, it is run immediately

json = '[ {
"word" : "xml"
}, {
"word" : "wiki"
}, {
"word" : "widgets"
}, {
"word" : "webapp"
}, {
"word" : "visualization"
}, {
"word" : "video"
}, {
"word" : "versioned"
}, {
"word" : "utterance"
}, {
"word" : "unicode"
}, {
"word" : "translation"
}, {
"word" : "tools"
}, {
"word" : "tipa"
}, {
"word" : "textgrids"
}, {
"word" : "tags"
}, {
"word" : "tablets"
}, {
"word" : "syntax tree"
}, {
"word" : "spectrogram"
}, {
"word" : "standards-compliant"
}, {
"word" : "session"
}, {
"word" : "semantics"
}, {
"word" : "segmentation"
}, {
"word" : "searchable"
}, {
"word" : "scripts"
}, {
"word" : "revert"
}, {
"word" : "research"
}, {
"word" : "repository"
}, {
"word" : "public/private"
}, {
"word" : "prosodylab aligner"
}, {
"word" : "programmers"
}, {
"word" : "praat"
}, {
"word" : "phonology"
}, {
"word" : "multiple orthographies"
}, {
"word" : "opensource"
}, {
"word" : "opendata"
}, {
"word" : "online"
}, {
"word" : "offline"
}, {
"word" : "olac"
}, {
"word" : "nosql"
}, {
"word" : "morphemes"
}, {
"word" : "modern"
}, {
"word" : "mobile"
}, {
"word" : "microphone"
}, {
"word" : "metadata"
}, {
"word" : "mcgill"
}, {
"word" : "mapreduce"
}, {
"word" : "longterm data archiving"
}, {
"word" : "linguists"
}, {
"word" : "lingsync"
}, {
"word" : "lexicon"
}, {
"word" : "lessons"
}, {
"word" : "leipzig glossing conventions"
}, {
"word" : "latex"
}, {
"word" : "language-learning module"
}, {
"word" : "laptops"
}, {
"word" : "javascript"
}, {
"word" : "json"
}, {
"word" : "iphone"
}, {
"word" : "ipad"
}, {
"word" : "ipa"
}, {
"word" : "internet"
}, {
"word" : "interns"
}, {
"word" : "information"
}, {
"word" : "import"
}, {
"word" : "images"
}, {
"word" : "ilanguage"
}, {
"word" : "hidden markov models"
}, {
"word" : "grammaticality judgements"
}, {
"word" : "gloss"
}, {
"word" : "github"
}, {
"word" : "free"
}, {
"word" : "fieldlinguists"
}, {
"word" : "export"
}, {
"word" : "encrypted"
}, {
"word" : "emeld"
}, {
"word" : "elicitation session"
}, {
"word" : "elan"
}, {
"word" : "discovery"
}, {
"word" : "dictionary"
}, {
"word" : "dialects"
}, {
"word" : "developers"
}, {
"word" : "datum"
}, {
"word" : "data"
}, {
"word" : "database"
}, {
"word" : "datalists"
}, {
"word" : "dataone"
}, {
"word" : "dashboard"
}, {
"word" : "customizable"
}, {
"word" : "csv"
}, {
"word" : "couchdb"
}, {
"word" : "corpus"
}, {
"word" : "consultant"
}, {
"word" : "community members"
}, {
"word" : "collaboration"
}, {
"word" : "chrome"
}, {
"word" : "browser"
}, {
"word" : "blog"
}, {
"word" : "automatic"
}, {
"word" : "attractive"
}, {
"word" : "audio"
}, {
"word" : "api"
}, {
"word" : "annotation"
}, {
"word" : "android"
}, {
"word" : "algorithm"
}, {
"word" : "accessible"
} ]'

buzzwords = JSON.parse json

SCHEDULER.every '2s', :first_in => 0 do |job|
  send_event('buzzwords', { text: buzzwords[rand(buzzwords.length - 1)]['word'] })
end