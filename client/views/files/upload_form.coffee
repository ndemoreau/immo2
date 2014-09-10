Template.uploadForm.events "change .myFileInput": (event, template) ->
#  console.log("Images defined: " + FsBanks);
#  FS.Utility.eachFile event, (file) ->
#    reader = new FileReader
#    reader.readAsText file
#    reader.onload = (event) ->
#      data = $.csv.toObjects(event.target.result)
#      console.log data

  FS.Utility.eachFile event, (file) ->
    Images.insert file, (err, fileObj) ->
      reader = new FileReader
      reader.readAsText file
      reader.onload = (event) ->
        data = $.csv.toObjects(event.target.result)
        console.log data


Template.uploadForm.rendered = ->
  console.log this.data