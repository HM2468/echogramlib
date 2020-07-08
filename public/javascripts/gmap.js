
    function initMap() {
        var map;
        var marker;
        var location = {lat: <%=raw @gram.lat %>, lng: <%=raw @gram.long %>};
        var  ref = {lat: 60, lng: 0};

        map = new google.maps.Map(
        document.getElementById('gmap'), {zoom: 4, center: ref});
        marker = new google.maps.Marker({
                                            position: location, 
                                            map: map,
                                            title: 'Echogram location' 
                                        });
    }


<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCtoY01RdrAUUdBbBSo3mwj7z-zuqza_QA&callback=initMap">
</script>