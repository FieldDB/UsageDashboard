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
"word" : "unicode"
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
"word" : "searchable"
}, {
"word" : "scripts"
}, {
"word" : "undo"
}, {
"word" : "research"
}, {
"word" : "public/private"
}, {
"word" : "prosodylab"
}, {
"word" : "praat"
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
"word" : "leipzig glossing conventions"
}, {
"word" : "latex"
}, {
"word" : "language-learning module"
}, {
"word" : "javascript"
}, {
"word" : "iphone"
}, {
"word" : "ipad"
}, {
"word" : "ipa"
}, {
"word" : "interns"
}, {
"word" : "import"
}, {
"word" : "images"
}, {
"word" : "hidden markov models"
}, {
"word" : "grammaticality judgements"
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
"word" : "elicitation sessions"
}, {
"word" : "elan"
}, {
"word" : "discovery"
}, {
"word" : "dialects"
}, {
"word" : "software engineering"
}, {
"word" : "data"
}, {
"word" : "database"
}, {
"word" : "dataone"
}, {
"word" : "customizable"
}, {
"word" : "csv"
}, {
"word" : "couchdb"
}, {
"word" : "corpus"
}, {
"word" : "community members"
}, {
"word" : "collaboration"
}, {
"word" : "chrome"
}, {
"word" : "automatic"
}, {
"word" : "cute"
}, {
"word" : "audio"
}, {
"word" : "restful api"
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
