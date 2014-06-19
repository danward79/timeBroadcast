
exec = require('child_process').exec

class TimeBroadcast 
  
  constructor: (params...) ->
    @period = params[1] * 1000
    @device = params[0]
    @interval = setupInterval @device, @period
    
  destroy: ->
    clearInterval(@interval)
    
  setupInterval = (device, period) ->
    interval = setInterval ( ->
      sendTime device
      ), period
    return interval
    
  sendTime = (device) ->
    #console.log "sendTime"
    d = new Date
    h = d.getHours()
    m = d.getMinutes()
    s = d.getSeconds()
    
    exec "echo 116,#{h},#{m},#{s},s > #{device}", (err, stdout, stderr) ->
      if err
        console.log "sudo exec child process exited with error code " + err.code
        return
        console.log stdout
      console.log "echo 116,#{h},#{m},#{s},s > #{device}"
exports.TimeBroadcast = TimeBroadcast

#tb = new TimeBroadcast("/dev/ttyUSB0", 10)
tb = new TimeBroadcast("/dev/ttyAMA0", 240)