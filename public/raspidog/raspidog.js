
const NODE_PORT = 3002;

const HOSTS = [ 
  '192.168.17.1',
  '192.168.17.11',
  '192.168.17.12',
  '192.168.17.13',
  '192.168.17.14',
  '192.168.17.15',
  '192.168.17.16',
  '192.168.17.17',
  '192.168.17.18',
]

var express = require('express');
var app =  express();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var sh = require('shelljs');
sh.config.silent = true;
require('shelljs/global');



// ROUTES


// static assets
[
  '/images/foundation.svg',
  '/images/jquery.svg',
  '/images/socket-io.svg',
  '/images/nodejs.svg',
  '/css/foundation.min.css',
  '/js/what-input.js',
  '/js/foundation.min.js',
  '/js/jquery.min.js'
].map(function(asset_path) {
  app.get(asset_path, function(req, res){
    res.sendFile(__dirname + asset_path);
  });
});


// index 
app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});


// Initialize available hosts 
var available_hosts = [];

HOSTS.map(function(host) {
  var cmd = __dirname + '/bin/ping.sh ' + host;
  exec(cmd, function(status, output) {
    if(output.trim() == '1') {
      console.log(host + ' is up');
      available_hosts.push(host);
    } else {
      console.log(host + ' not up');
    }
  });
});

// CONNECTIONS

var guests = 0;

io.on('connection', function(socket) {

    if(guests === 0) {
      time = setInterval(function() { deliverWorkloads(socket) }, 1000);
      console.log("interval started");
    }

    socket.on('disconnect', function() {
      guests -= 1;
      console.log('guest disconnected');
      if(guests === 0) {
        clearInterval(time);
        console.log("interval cleared");
      }
    });

    guests += 1;
    console.log('guest connected (' + guests + ' guests)');
}); 


// deliver workloads for hosts

function deliverWorkloads(socket) {
  // console.log('delivering');
  available_hosts.map(function(address) {
    workloadFor(address, socket);
  });
}

function workloadFor(ipAddress, socket) {

    exec(__dirname + '/bin/workload.sh ' + ipAddress, function(status, output) {

      if(status === 0) {
        var workload = output.split(',');
        var cpu_idle          = workload[0];
        var memory_available  = workload[1] - 0;   // 745392
        var memory_total      = workload[2] - 0;   // 948012
        var memory_shared     = workload[3] - 0;   // 12260
        var memory_buffer     = 0; // workload[4] - 0;   // 16728
        var memory_cached     = workload[5] - 0;   // 147876

        // console.log(cpu_idle,memory_available,memory_total,memory_shared,memory_buffer,memory_cached);
        var memory_free = memory_available + memory_shared + memory_buffer + memory_cached; // 922256
        // console.log("free", memory_free);
        var memory_used = (memory_total - memory_free ) ;

        var response = {
          "ip_address": ipAddress,
          "workload": {
            "cpu": { 
                "used_percent": (100 - cpu_idle)
              },
              "memory": {
                "used_percent": Math.round(( memory_used * 100 ) / memory_total),
                "used"        : memory_used,
                "total"       : memory_total
             }  
          }
        };

        socket.broadcast.emit('workload', response);
      } else {
        console.log("something went wrong with " + ipAddress);
      }
    });

};


http.listen(NODE_PORT, function(){
  console.log('listening on *:' + NODE_PORT);
});
