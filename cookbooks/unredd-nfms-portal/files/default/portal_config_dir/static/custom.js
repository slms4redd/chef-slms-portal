UNREDD.maxExtent = new OpenLayers.Bounds(-20037508, -20037508, 20037508, 20037508);
UNREDD.restrictedExtent = new OpenLayers.Bounds(-20037508, -20037508, 20037508, 20037508);
UNREDD.maxResolution = 4891.969809375;
UNREDD.mapCenter = new OpenLayers.LonLat(2500000, -400000);
UNREDD.defaultZoomLevel = 0;

UNREDD.wmsServers = [
    "http://demo1.geo-solutions.it",
    "http://incuweb84-33-51-16.serverclienti.com"
];

UNREDD.layerInfo = {
    drc_provinces: function(feature) {
        var that = {};
        that.title = function() {
            return messages.province + ": " + feature.attributes.PROVINCE;
        };
        that.statsLink = function() {
            return UNREDD.wmsServers[0] + '/stg_geostore/rest/misc/category/name/ChartData/resource/name/deforestation_script_' +  feature.attributes.OBJECTID + '_' + languageCode + '/data?name=' + feature.attributes.PROVINCE;
        };
        return that;
    }
}
