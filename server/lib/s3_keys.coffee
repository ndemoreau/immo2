S3_keyId = process.env.S3_KEYID
S3_secretId = process.env.S3_ACCESS_KEY
Meteor.methods
  s3_key: ->
    if S3_keyId
      S3_keyId
    else
      throw Error()

  s3_secret: ->
    if S3_secretId
      S3_secretId
    else
      throw Error()
