Router.map ->
  @route "fsbanks",
    path: "/fsbanks"
    waitOn: ->
      [subs.subscribe "allFsbanks",
        subs.subscribe "allTransactions"]

    data: ->
      fsbanks: Fsbanks.find()
      FsbanksCollection: Fsbanks

