# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

gm_init = ->

  maxZoomLevel = 14

  # map config
  map_options =
    center: new google.maps.LatLng 49.284337, -123.121119
    zoom: maxZoomLevel
    mapTypeId: google.maps.MapTypeId.ROADMAP
    panControl: false
    zoomControl: false
    mapTypeControl: false
    scaleControl: false
    streetViewControl: false
    overviewMapControl: false

  map = new google.maps.Map @map_canvas, map_options

  # limit zoom
  google.maps.event.addListener map, 'zoom_changed', ->
   if map.getZoom() < maxZoomLevel then map.setZoom maxZoomLevel

  # limit bounds
  strictBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng 49.265129, -123.147812
    new google.maps.LatLng 49.295477, -123.08198
  )

  google.maps.event.addListener map, 'dragend', ->
    if strictBounds.contains map.getCenter() then return

    # out of bounds—move back into bounds

    c = map.getCenter()
    x = c.lng()
    y = c.lat()
    maxX = strictBounds.getNorthEast().lng()
    maxY = strictBounds.getNorthEast().lat()
    minX = strictBounds.getSouthWest().lng()
    minY = strictBounds.getSouthWest().lat()

    if x < minX then x = minX
    if x > maxX then x = maxX
    if y < minY then y = minY
    if y > maxY then y = maxY

    map.setCenter new google.maps.LatLng(y, x)


  return map

geocoder = new google.maps.Geocoder()

addMarkerAt = (address, map) ->
  geocoder.geocode {'address': address+' vancouver bc'}, (results) ->
    marker = new google.maps.Marker
      map: map
      position: results[0].geometry.location

$ ->
  map = gm_init()

  $.ajax
    url: '/vendors.json'
    type: 'GET'
    success: (response) ->
      addMarkerAt vendor.address, map for vendor in response when vendor.address isnt null