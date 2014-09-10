Template.fsbanks.events "change .myFileInput": (event, template) ->
  FS.Utility.eachFile event, (file) ->
    Fsbanks.insert file, (err, fileObj) ->
      reader = new FileReader
      reader.readAsText file
      reader.onload = (event) ->
        data = $.csv.toObjects(event.target.result)
        console.log "File read #{data}"
        _.map data, (transaction) ->
          console.log transaction
          t = {}
          selectValues = {}
          date = transaction["Value date"]
          date_array = date.split("/")
          new_date = date_array[2] + "-" + date_array[1] + "-" + date_array[0]
          console.log new_date
          selectValues["account_nbr"] = transaction["Account number"]
          selectValues["value_date"] = new Date new_date
          selectValues["entry_nbr"] = parseInt transaction["Entry number"]
          t["amount"] = transaction["Amount in the currency of the account"].replace(/\s/g, '')
          t["status"] = "open"
          t["description"] = transaction["Description"]
          Meteor.call "createTransaction", t, selectValues
#      if err
#        Notifications.danger err
#      else
#        console.log "File saved"
#        console.log fileObj
#    Meteor.call "importTransactions", file, (error, result) ->



Template.uploadForm.rendered = ->
  #console.log this.data