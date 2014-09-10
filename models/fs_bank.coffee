#@Fsbanks = new FS.Collection("fsBanks",
#  stores: [new FS.Store.FileSystem("fsBanks",
#    path: "~/uploads"
#  )]
#)

s3Store = new FS.Store.S3("fsbanks",
  bucket: "immondm" #required
  path: "banks"

)

#s3Store.on("stored", function (storeName, fileObj) {
#  if (storeName !== "fsbanks")
#    return
#});

@Fsbanks = new FS.Collection("fsbanks",
  stores: [s3Store]
)

FS.debug = true

Fsbanks.allow
  insert: ->
    true
  update: ->
    true
  remove: ->
    false
  download: ->
    true
  fetch: []
