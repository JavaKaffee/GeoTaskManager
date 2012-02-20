function initialize_existing_map()
{
    if (document.getElementById("existing_map_canvas") != null) {
        var myLatlng = new google.maps.LatLng(parseFloat(document.getElementById('latitude').value),parseFloat(document.getElementById('longitude').value));
        var myOptions = {
            zoom: 16,
            zoomControl: false,
            streetViewControl: false,
            mapTypeControl: false,
            panControl: false,
            rotateControl: false,
            scaleControl: false,
            scrollWheel: false,
            center: myLatlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        var map = new google.maps.Map(document.getElementById("existing_map_canvas"), myOptions);
        
        var circleOptions = {
          strokeColor: "#CC0000",
          strokeOpacity: 0.8,
          strokeWeight: 2,
          fillColor: "#FFFF00",
          fillOpacity: 0.15,
          map: map,
          center: map.center,
          radius: 150
        };
        cityCircle = new google.maps.Circle(circleOptions);
        
        var image = '../assets/computers.png';
        var marker = new google.maps.Marker({
            position: myLatlng,
            icon: image,
            title:"Sie sind hier!"
        });
  
        // To add the marker to the map, call setMap();
        marker.setMap(map); 
    }
}

function initialize_map()
{
    if (document.getElementById("map_canvas") != null) {
        var myOptions = {
            zoom: 13,
            mapTypeControl: false,
            streetViewControl: false,
            navigationControl: true,
            navigationControlOptions: {
                style: google.maps.NavigationControlStyle.LARGE
            },
            zoomControl: true,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.LARGE,
                position: google.maps.ControlPosition.TOP_RIGHT
            },
            mapTypeId: google.maps.MapTypeId.ROADMAP      
        }	
        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    }
}

function initialize()
{
    if (document.getElementById("map_canvas") != null) {
        if(document.getElementById('latitude').value != "") {
            var pos=new google.maps.LatLng(parseFloat(document.getElementById('latitude').value),parseFloat(document.getElementById('longitude').value));
            
            var myOptions = {
                zoom: 12,
                center: pos,
                mapTypeControl: false,
                streetViewControl: false,
                navigationControl: true,
                navigationControlOptions: {
                    style: google.maps.NavigationControlStyle.SMALL
                },
                mapTypeId: google.maps.MapTypeId.ROADMAP      
            }
            
            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            
            var marker = new google.maps.Marker({
                position: pos,
                streetViewControl: false,
                mapTypeControl: false,
                draggable: true,
                map: map,
                title:"Sie sind in hier"
            });
            
            google.maps.event.addListener(marker, 'dragend', function() {
                document.getElementById('latitude').value=marker.getPosition().lat().toFixed(8);
                document.getElementById('longitude').value=marker.getPosition().lng().toFixed(8);
            });
        } else {
            if(geo_position_js.init())
            {
                document.getElementById('longitude').value="Receiving...";
                document.getElementById('latitude').value="Receiving...";
                geo_position_js.getCurrentPosition(show_position,function(){
                    document.getElementById('longitude').value="Couldn't get location"
                    document.getElementById('latitude').value="Couldn't get location"
                },{
                    enableHighAccuracy:true
                });
            }
            else
            {
                document.getElementById('longitude').value="Functionality not available";
                document.getElementById('latitude').value="Functionality not available";
            }
        }
    }
    
}

function show_position(p)
{
    document.getElementById('longitude').value=p.coords.longitude.toFixed(8);
    document.getElementById('latitude').value=p.coords.latitude.toFixed(8);
    var pos=new google.maps.LatLng(p.coords.latitude,p.coords.longitude);
    map.setCenter(pos);
    map.setZoom(12);

    var marker = new google.maps.Marker({
        position: pos,
        streetViewControl: false,
        mapTypeControl: false,
        draggable: true,
        map: map,
        title:"Sie sind in etwa hier"
    });
        
    google.maps.event.addListener(marker, 'dragend', function() {
        document.getElementById('latitude').value=marker.getPosition().lat().toFixed(8);
        document.getElementById('longitude').value=marker.getPosition().lng().toFixed(8);
    });
	
}