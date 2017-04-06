angular.module('newApp').factory('distance', function () {

	var nn = {};

	Number.prototype.toRad = function() {
		return this * Math.PI / 180;
	};

	nn.calculate = function(origin,destination){
		var lat1=origin.lat;
		var lat2=destination.lat;
		var lon1=origin.lon;
		var lon2=destination.lon;
		return Math.acos(Math.sin(lat1.toRad())*Math.sin(lat2.toRad())+Math.cos(lat1.toRad())*Math.cos(lat2.toRad())*Math.cos(lon2.toRad()-lon1.toRad()));
	}

	nn.getDistancefromHaversine = function(origin,destination){

		var R = 6371; // Radius of the earth in km
		var dLat = (origin.lat-destination.lat).toRad();  // Javascript functions in radians
		var dLon = (origin.lon-destination.lon).toRad();
		var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
		Math.cos(origin.lat.toRad()) * Math.cos(destination.lat.toRad()) *
		Math.sin(dLon/2) * Math.sin(dLon/2);
		var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		return R * c; // Distance in km
	}

	nn.getDistancefromCosine = function(origin,destination){
		var lat1=origin.lat;
		var lat2=destination.lat;
		var lon1=origin.lon;
		var lon2=destination.lon;
		return Math.acos(Math.sin(lat1.toRad())*Math.sin(lat2.toRad())+ Math.cos(lat1.toRad())*Math.cos(lat2.toRad())*Math.cos(lon2.toRad()-lon1.toRad()))*6371;
	}
	
	nn.getDivisionRatio = function(origin,current,destination){
		var d0 = this.calculate(origin,current);
		var d1 = this.calculate(current,destination);
		return (d1/d0);
	}

	return nn;

});
