var express = require('express');
var app = express();
var request = require("request");
var https = require('https');
var httpBuildQuery = require('http-build-query');
var port = process.env.PORT || 8080;
app.use(express.static(__dirname + "/"));





//get geocoding of a location
app.get('/hw8/geoCoding?*',function(req,res){
        var queryObj = req.query;
        
        console.log("got the geo coding request");
        console.log("query is"+JSON.stringify(queryObj));
        var location = queryObj.location;
        console.log(location);
        var url="https://maps.googleapis.com/maps/api/geocode/json?address="+location+"&key=AIzaSyDoVODnw4WlGn2xE6kW_d9WzOsp1v6c79k";
        request({url:url,json:true},function(error,response,body){
            if(!error && response.statusCode==200){
               
                //var geocoding = JSON.parse(body);
                console.log("body is");
                console.log(body);
                res.header("Access-control-Allow-Origin","*");
                res.header("Access-control-Allow-Headers","X-Requested-With");
                res.json(body);
                
                              
            }
        })
});


//get geoNearby
app.get('/hw8/geoNearby?*',function(req,res){
        var queryObj = req.query;
        
        console.log("got the geo nearby request");
        console.log("query is"+JSON.stringify(queryObj));
        var location = queryObj.location;
        console.log(location);
        var url="https://maps.googleapis.com/maps/api/geocode/json?address="+location+"&key=AIzaSyDoVODnw4WlGn2xE6kW_d9WzOsp1v6c79k";
        request({url:url,json:true},function(error,response,body){
            if(!error && response.statusCode==200){
               
                //var geocoding = JSON.parse(body);
                console.log("body is");
                
                console.log(body);
                //res.json(body);
                
                var lat = body.results[0].geometry.location.lat;
                var lng = body.results[0].geometry.location.lng;
                
                
                console.log(lat+"lng is "+lng);
                var geo = "location="+lat+","+lng+"&";
                delete queryObj.location;
                var query = httpBuildQuery(queryObj);
                var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"+geo+query+"&key=AIzaSyDoVODnw4WlGn2xE6kW_d9WzOsp1v6c79k";
                console.log(url);
                request({
                    url:url,
                    json:true
                },function(error,response,body){
                    if(!error && response.statusCode==200){
                        res.header("Access-control-Allow-Origin","*");
                        res.header("Access-control-Allow-Headers","X-Requested-With");
                        res.json(body);
                    }
                })
                
                
            }
        })
});


app.get('/hw8/getNext?*',function(req,res){
   
        console.log("got the get next request");
        var query = httpBuildQuery(req.query);
        var url="https://maps.googleapis.com/maps/api/place/nearbysearch/json?"+query+"&key=AIzaSyDoVODnw4WlGn2xE6kW_d9WzOsp1v6c79k";
        request({url:url,json:true},function(error,response,body){
            if(!error && response.statusCode==200){
                //var geocoding = JSON.parse(body);
                console.log("body is");
                console.log(body);
                res.header("Access-Control-Allow-Origin","*");
                res.header("Access-Control-Allow-Headers","X-Requested-With");
                res.json(body);
                
            }
        })
});


//get nearby details
app.get('/hw8/getNearby?*',function(req,res){
        console.log("got the get nearby request");
        console.log(req.query);
        var query = httpBuildQuery(req.query);
        console.log(query);
        var url="https://maps.googleapis.com/maps/api/place/nearbysearch/json?"+query+"&key=AIzaSyDoVODnw4WlGn2xE6kW_d9WzOsp1v6c79k";
        //console.log(url);
        request({
            url:url,
            json:true
        },function(error,response,body){
            if(!error && response.statusCode==200){
                res.header("Access-control-Allow-Origin","*");
                res.header("Access-control-Allow-Headers","X-Requested-With");
                res.json(body);
            }
        })
});

//get details of one place from yelp
app.get('/hw8/getDetails?*',function(req,res){
        console.log("got the get details request");
        console.log(req.query);
        var query = httpBuildQuery(req.query);
        console.log(query);
        var url="https://api.yelp.com/v3/businesses/matches/best?"+query;
        //console.log(url);
        request({
            url:url,
            headers:{
                'Authorization':'Bearer Gk5lSy9jaT9_HhyYnbbDBZHUdxohupDr8217B6bVj51vlqkVmIT6K7OzSNlidw-ghk_iMSB8d8SCqqBHpgMEWDHg-gUFYUAqrdeOL450SnJBF6ZPbRLr6rJBhE25WnYx'
            },
            json:true
            
        },function(error,response,body){
            if(!error && response.statusCode==200){
                res.header("Access-control-Allow-Origin","*");
                res.header("Access-control-Allow-Headers","X-Requested-With");
                res.json(body);
            }
        })
});

//get place details from google
app.get('/hw8/getGoogleDetails?*',function(req,res){
        console.log("got the google detail request");
        console.log(req.query);
        var query = httpBuildQuery(req.query);
        console.log(query);
        var url="https://maps.googleapis.com/maps/api/place/details/json?"+query+"&key=AIzaSyDoVODnw4WlGn2xE6kW_d9WzOsp1v6c79k";
        //console.log(url);
        request({
            url:url,
            json:true
        },function(error,response,body){
            if(!error && response.statusCode==200){
                res.header("Access-Control-Allow-Origin","*");
                res.header("Access-Control-Allow-Headers","X-Requested-With");
                res.json(body);
            }
        })
});


//get reviews from yelp
app.get('/hw8/getReview?*' ,function(req,res){
        console.log("got the get review request");
        console.log(req.query);
        var place_id = req.query.place_id;

        console.log(place_id);
        var url="https://api.yelp.com/v3/businesses/"+place_id+"/reviews";
        console.log(url);
        request({
            url:url,
            headers:{
                'Authorization':'Bearer Gk5lSy9jaT9_HhyYnbbDBZHUdxohupDr8217B6bVj51vlqkVmIT6K7OzSNlidw-ghk_iMSB8d8SCqqBHpgMEWDHg-gUFYUAqrdeOL450SnJBF6ZPbRLr6rJBhE25WnYx'
            },
            json:true
        },function(error,response,body){
            if(!error && response.statusCode==200){
                res.header("Access-control-Allow-Origin","*");
                res.header("Access-control-Allow-Headers","X-Requested-With");
                res.json(body);
            }
        })
});





app.listen(port);
