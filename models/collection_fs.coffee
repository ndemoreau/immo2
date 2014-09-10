#@Images = new FS.Collection("images",
#  stores: [new FS.Store.FileSystem("images",
#    path: "~/uploads"
#  )]
#)

s3Store = new FS.Store.S3 "images",
  bucket: "immondm" #required


@Images = new FS.Collection("images",
  stores: [s3Store]
)

FS.debug = true

Images.allow
  insert: ->
    true
  update: ->
    true
  remove: ->
    false
  download: ->
    true
  fetch: []
