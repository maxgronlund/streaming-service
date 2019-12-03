$(document).on("turbolinks:load", function() {

  $(".play-button").click( function() {

    if(authorized()) {
      var work_id = $( this ).attr("work-id")
      var track_id = $( this ).attr("track-id")
      fetch_audio_uri(work_id, track_id);
    } else {
      authenticate_user();
    }
    // $.ajax({
    //   url: "/authorize/123"
    // });
    // .done(function(html) {
    //   return $("#results").append(html);
    // });
  });


});

function authorized() {
  return $("#authorized").attr('value') == "true";
};

function authenticate_user() {
  $.ajax({
      url: "/authentication_open_dialog"
    });
  // .done(function() {
  //     // return $("#results").append(html);
  //   });
};

function fetch_audio_uri(work_id, track_id) {
  // console.log("fetch_audio_uri")
  // console.log(work_id);
  // console.log(track_id);
  // var csrf_token = $('meta[name="csrf-token"]').attr('content');
  // $.ajaxSetup({
  //   headers:
  //   { 'X-CSRF-TOKEN': csrf_token }
  // });
  $.ajax({
  type: 'GET',
  url: "/authorize/track/",
  jsonpCallback: 'testing',
  data: {work_id: work_id, track_id: track_id},
  dataType: 'json'
  // success: function(json) {
  //     console.log(json);
  // },
  // error: function(e) {
  //     console.log(e.message);
  // }
  });

  // $.ajax({
  //     url: "/authorize/track/",
  //     data: {work_id: work_id, track_id: track_id}
  //   })
  // .done(function() {
  //     // return $("#results").append(html);
  // });
};


