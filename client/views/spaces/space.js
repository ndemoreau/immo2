/* ---------------------------------------------------- +/

## space ##

Code related to the space template

/+ ---------------------------------------------------- */

Template.space.created = function () {
  //
};

Template.space.helpers({
  
  created_on: function () {
    var day = new Date(this.creation_date);
    return moment(day).fromNow();
  }

});


Template.space.rendered = function () {
  //
};

Template.space.events({

  'click .delete': function(e, instance){
    var space = this;
    e.preventDefault();
    Meteor.call('removeSpace', space, function(error, result){
      alert('space deleted.');
      Router.go('/spaces');
    });
  }


});
