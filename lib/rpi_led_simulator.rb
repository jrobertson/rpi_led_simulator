#!/usr/bin/env ruby

# file: rpi_led_simulator.rb

require 'colored'

class RPiLedSimulator
   
  @leds = []

  class PinX


    def initialize(id, color: :red, parent: nil)
      @id = id
      @on, @blinking = false, false
      @color = color
      @parent = parent

    end

    def color()
      @on ? @color : :black
    end

    def on(durationx=nil, duration: nil)
      
      @on = true      
      duration ||=  durationx
      
      @off_thread.exit if @off_thread
      @on_thread = Thread.new {(sleep duration; off()) } if duration

    end

    def off(durationx=nil, duration: nil)
      
      @on, @blinking = false, false      
      duration ||=  durationx
      
      @on_thread.exit if @on_thread
      @off_thread = Thread.new { (sleep duration; on()) } if duration

    end
    
    
    alias stop off        

    def blink(seconds=0.5, duration: nil)

      @blinking = true
      t2 = Time.now + duration if duration

      Thread.new do
        while @blinking do
          (@on  = true; sleep seconds; @on = false; sleep seconds) 
          @on = false; @blinking = false if duration and Time.now >= t2
        end
        
      end
    end
    
    def on?()  @on  end
    def off?() !@on end
    
    def to_s()
      @id
    end
  end
  
  class Void
    def on(duration=nil)               end
    def off()                          end
    def blink(seconds=0, duration=nil) end
    alias stop off
  end  

  def initialize(x=[], color: :red, symbol: '▋', spacer: 0, colors: [])

    @color, @symbol, @spacer, @colors = color, symbol, spacer, colors
    
    a = case x
    when Fixnum
      [x]
    when String
      [x]
    when Array
      x
    end

    @pins = a.map.with_index do |pin, i|
      
      PinX.new pin, color: colors[i] || color, parent: self 
      
    end
    
    def @pins.[](i)

      if i.respond_to? :to_i and i.to_i >= self.length then
        puts "RPi warning: PinX instance #{i.inspect} not found"
        Void.new
      else
        super(i)
      end 
    end    
    
  end

  def pin()   @pins.first  end
  def pins()
    @pins
    'done'
  end

  def refresh(n=0)

    # get the pin value

    colors = @pins.map {|pin| pin.color }
    a = [" ".on_white]
    a.concat colors.map{|c| @symbol.method((c.to_s + '_on_white').to_sym).call }
    
    print "\r " + a.join(" ".on_white * @spacer.to_i) + " ".on_white + " "

    return if n < 1

    sleep 0.01
    refresh n-1

  end

  def watch(n=2.8)
    refresh n * 100
    puts
  end
    
end