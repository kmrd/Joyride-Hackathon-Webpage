$(window).load(function() {
  loadScript();
});

var map;

function initialize() {
        
  var mapOptions = {
          center: new google.maps.LatLng(43.659891, -79.388625),
          zoom: 16,
          mapTypeId: google.maps.MapTypeId.NORMAL,
          panControl: true,
          scaleControl: false,
          streetViewControl: true,
          overviewMapControl: true
        };

  // initializing map
  map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);
        
  // geocoding 
  var geocoding  = new google.maps.Geocoder();
  $("#submit_button_geocoding").click(function(){
    codeAddress(geocoding);
  });
  $("#submit_button_reverse").click(function(){
    codeLatLng(geocoding);
  });
  

  if (typeof localMapChanges === "function") {
    localMapChanges();
  }
   
}

var info;
function codeLatLng(geocoding){

  var input = $('#search_box_reverse').val();
  console.log(input);
  
  var latlngbounds = new google.maps.LatLngBounds();
  var listener;
  var regex = /([1-9])+\.([1-9])+\,([1-9])+\.([1-9])+/g;
  if(regex.test(input)) {
  var latLngStr = input.split(",",2);
  var lat = parseFloat(latLngStr[0]);
  var lng = parseFloat(latLngStr[1]);
  var latLng = new google.maps.LatLng(lat, lng);
  geocoding.geocode({'latLng': latLng}, function(results, status) {
     if (status == google.maps.GeocoderStatus.OK){
       if(results.length > 0){
         //map.setZoom(11);
         var marker;
         map.setCenter(results[1].geometry.location);
         var i;
        info = createInfoWindow("");
         for(i in results){
           latlngbounds.extend(results[i].geometry.location);
             marker = new google.maps.Marker({
             map: map,
             position: results[i].geometry.location
           });
          
          google.maps.event.addListener(marker, 'click', (function(marker,i) {
            return function() {
            info.setContent(results[i].formatted_address);
            info.open(map,marker);
            }
          })(marker,i));
        }

         map.fitBounds(latlngbounds);
         listener = google.maps.event.addListener(map, "idle", function() {
          if (map.getZoom() > 16) map.setZoom(16);
            google.maps.event.removeListener(listener);
          });
       }
     }
    else{
       alert("Geocoder failed due to: " + status);
     }  
  });
  }else{
    alert("Wrong lat,lng format!");
  }
}
function codeAddress(geocoding){
  var address = $("#search_box_geocoding").val();
  if(address.length > 0){
    geocoding.geocode({'address': address},function(results, status){
      if(status == google.maps.GeocoderStatus.OK){
        map.setCenter(results[0].geometry.location);
        var marker  =  new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
        });
        }else{
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  }else{
    alert("Search field can't be blank");
  }
}



var marker;
function createMarker(lat, lng, map, title){
  var coords = new google.maps.LatLng(lat, lng);

  marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title
  });
}




var linePath;
var lineSymbol = {
  path: 'M 0,-1 0,1',
  scale: 4,
  strokeOpacity: 1,
  strokeColor: '#f2af0e'
};
function createPolyline(map,lineCoordinates,lineSymbol){
  linePath = new google.maps.Polyline({
    path: lineCoordinates,
    geodesic: true,
    strokeColor: '#f2af0e',
    strokeOpacity: 1.0,
    strokeWeight: 4
   });
 linePath.setMap(map);
} 



function createImage(url){
  var image = {
    url: url,
    // This marker is 32 pixels wide by 32 pixels tall.
    size: new google.maps.Size(32, 32),
    // The origin for this image is 0,0.
    origin: new google.maps.Point(0,0),
    // The anchor for this image is the base of the flagpole at 0,32.
    anchor: new google.maps.Point(0, 32)
  };
  return image;
}

function createCustomMarker(lat, lng, map, title){
  var coords = new google.maps.LatLng(lat, lng);
  marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title,
    icon: createImage("/assets/icon.png")
  });
}



function loadScript() {
	console.log("map loading ...");
  var script = document.createElement('script');
  script.type = 'text/javascript';
  //'https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyBJYFdplGeKUUEmGZ-vL4ydiSZ09Khsa_o&sensor=false&libraries=drawing'
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp' +
    //'&v=3.14'+
    //'&key=AIzaSyBJYFdplGeKUUEmGZ-vL4ydiSZ09Khsa_o'+
    '&libraries=drawing'+
    '&callback=initialize';
  document.body.appendChild(script);
}
