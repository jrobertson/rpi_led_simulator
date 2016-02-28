# Introducing the rpi_led_simulator gem


    require 'rpi_led_simulator'

    # the symbol ● represents the round LED or ▋ to represent a bar LED
    rpi = RPiLedSimulator.new(4, symbol: '●')

    rpi.pins.first.blink duration: 3; rpi.watch

Output:

Here's a quick [video](http://www.jamesrobertson.eu/videos/2016/feb/28/demo-of-the-rpi_led_simulator-in-an-irb-session.html), showing a virtual LED blinking for 4 seconds.


I was motivated to write this gem after experimenting with a super bright LED bar graph which wasn't good for my eyes to look at for any length of time. I could of course reduced the brightness, however that would have taken more effort in searching around for other resistors etc.

## Resources

* rpi_led_simulator https://rubygems.org/gems/rpi_led_simulator

rpi led rpi_led_simulator gem
