# based on original file:
# University of Washington, Programming Languages, Homework 6, hw6graphics.rb

# Swing backend for jruby
# Author: Peter Cox

require 'java'

class TetrisRoot
  def initialize
    #@root = TkRoot.new('height' => 615, 'width' => 205, 
    #         'background' => 'lightblue') {title "Tetris"}
    @root = javax.swing.JFrame.new("Tetris")
    contentPane = javax.swing.JPanel.new
    contentPane.setOpaque(true)
    contentPane.setBackground(TetrisColors.get_color("lightblue"))
    contentPane.setPreferredSize(java.awt.Dimension.new(205, 615))
    contentPane.setLayout(nil)
    @root.setContentPane(contentPane)
    @root.pack
    @root.addWindowListener(TetrisWindowListener.new)
  end

  def bind(char, callback)
    contentPane = @root.getContentPane
    key = "actionKey" + char
    stroke = javax.swing.KeyStroke.getKeyStroke(Keys[char], 0);
    contentPane.getInputMap(javax.swing.JComponent::WHEN_IN_FOCUSED_WINDOW).put(stroke, key);
    contentPane.getActionMap().put(key, TetrisActionListener.new(callback))
  end
  
  Keys = Hash[
    'n' => java.awt.event.KeyEvent::VK_N,
    'p' => java.awt.event.KeyEvent::VK_P,
    'q' => java.awt.event.KeyEvent::VK_Q,
    'a' => java.awt.event.KeyEvent::VK_A,
    'Left' => java.awt.event.KeyEvent::VK_LEFT,
    'd' => java.awt.event.KeyEvent::VK_D,
    'Right' => java.awt.event.KeyEvent::VK_RIGHT,
    's' => java.awt.event.KeyEvent::VK_S,
    'Down' => java.awt.event.KeyEvent::VK_DOWN,
    'w' => java.awt.event.KeyEvent::VK_W,
    'Up' => java.awt.event.KeyEvent::VK_UP,
    'space' => java.awt.event.KeyEvent::VK_SPACE,
    'u' => java.awt.event.KeyEvent::VK_U,
    'c' => java.awt.event.KeyEvent::VK_C]


  # Necessary so we can unwrap before passing to Tk in some instances.
  # Student code MUST NOT CALL THIS.
  attr_reader :root
end

class TetrisTimer
  def initialize
  end

  def stop
    if (not(@timer.nil?))
      @timer.stop
      Timers.delete(@timer)
    end
  end

  def start(delay, callback)
    stop
    @timer = javax.swing.Timer.new(delay, TetrisActionListener.new(callback))
    @timer.start()
    Timers.push(@timer)
  end
  Timers = Array.new
  
  def self.stopAll
    Timers.each{|timer| timer.stop}
    Timers.clear
  end
end


class TetrisCanvas
  def initialize
    @canvas = MyCanvas.new
    @canvas.setBackground(TetrisColors.get_color('grey'))
  end

  def place(height, width, x, y)
    @canvas.setBounds(java.awt.Rectangle.new(x, y, width, height))
    
    # the original tk code magically seems to add itself to a window
    # we can store a reference to our tetris window
    # or hack it
    java.awt.Frame.getFrames()[0].getContentPane().add(@canvas, "canvas")
  end

  def unplace
    @canvas.getParent.remove(@canvas)
  end

  def delete
    @canvas = nil
  end

  # Necessary so we can unwrap before passing to Tk in some instances.
  # Student code MUST NOT CALL THIS.
  attr_reader :canvas
end

class MyCanvas < javax.swing.JComponent
  
  def initialize
    @rects = Array.new
  end
  
  def paint(graphics)
    graphics.setColor(getBackground)
    size = getSize
    graphics.fillRect(0, 0, size.width, size.height)
     @rects.each{|rect|
      bounds = rect.bounds
      graphics.setColor(rect.outlineColor)
      graphics.drawLine(bounds.x, bounds.y, bounds.x + bounds.width, bounds.y)
      graphics.drawLine(bounds.x, bounds.y, bounds.x, bounds.y + bounds.height)
      graphics.drawLine(bounds.x, bounds.y + bounds.height, bounds.x + bounds.width, bounds.y + bounds.height)
      graphics.drawLine(bounds.x + bounds.width, bounds.y,  bounds.x + bounds.width, bounds.y + bounds.height)
      
      graphics.setColor(rect.fillColor)
      graphics.fillRect(bounds.x + 1, bounds.y + 1, bounds.width - 2, bounds.height - 2)
    }
  end

  def addRect(rect)
    @rects.push(rect)
    repaint()
  end
  
  def removeRect(rect)
    @rects.delete(rect)
    repaint()
  end
end

class TetrisLabel
  def initialize(wrapped_root, &options)
    unwrapped_root = wrapped_root.root
    @label = MyLabel.new(unwrapped_root, &options)
  end

  def place(height, width, x, y)
    @label.setBounds(java.awt.Rectangle.new(x, y, width, height))
  end

  def text(str)
    @label.setText(str.to_s)
  end
end


class MyLabel < javax.swing.JLabel
  
  def initialize(parent, &options)
    super()
    setBorder(nil)
    instance_eval(&options) if block_given?
    parent.getContentPane.add(self, "label")
    setFont(getFont.deriveFont(8.0))
  end
  
  def text(text)
    setText(text)
  end
  def command(thelabel)
    @command = thelabel
  end
  def background(color)
    setBackground(TetrisColors.get_color(color))
  end
  
end

class TetrisButton
  def initialize(label, color)
    @button = javax.swing.JButton.new(label)
    @button.setBorder(nil)
    @button.setOpaque(true)
    @button.setBackground(TetrisColors.get_color(color))
    @button.addActionListener(TetrisActionListener.new(proc {yield}))
    
    # disable focus because <space> is an action event trigger
    @button.setFocusable(false)
  end

  def place(height, width, x, y)
    @button.setBounds(java.awt.Rectangle.new(x, y, width, height))
    
    # the original tk code magically seems to add itself to a window
    # we can store a reference to our tetris window
    # or hack it
    java.awt.Frame.getFrames()[0].getContentPane().add(@button)
  end
  
end

class TetrisColors
  def self.get_color(color)
    ColorMap[color]
  end
  
  ColorMap = {"lightcoral" => java.awt.Color.new(240, 128, 128),
    "lightgreen" => java.awt.Color.new(144, 238, 144),
    "lightblue"=> java.awt.Color.new(173, 216, 230),
    'grey' => java.awt.Color.new(190, 190, 190),
    'DarkGreen' => java.awt.Color.new(0, 100, 0),
    'dark blue' => java.awt.Color.new(0, 0, 139), 
    'dark red' => java.awt.Color.new(139, 0, 0),
    'gold2' => java.awt.Color.new(238, 201, 0),
    'Purple3'=> java.awt.Color.new(125, 38, 205), 
    'OrangeRed2' => java.awt.Color.new(238, 64, 0),
    'LightSkyBlue' => java.awt.Color.new(135, 206, 250),
    'black' => java.awt.Color::BLACK}
end

class TetrisActionListener < javax.swing.AbstractAction
  def initialize(theProc)
    super()
    @theProc = theProc
  end
  def actionPerformed(actionEvent)
    @theProc.call
  end
end

class TetrisWindowListener < java.awt.event.WindowAdapter
  def windowClosing(windowEvent)
    super(windowEvent)
    exitProgram
  end
end


class TetrisRect
  def initialize(wrapped_canvas, a, b, c, d, color)
    unwrapped_canvas = wrapped_canvas.canvas
    @rect = MyRect.new(unwrapped_canvas, a, b, c, d, 
                             TetrisColors.get_color('black'), TetrisColors.get_color(color))
  end

  def remove
    @rect.remove
  end

  def move(dx, dy)
    @rect.move(dx, dy)
  end

end

class MyRect
  def initialize (parent, x1, y1, x2, y2, outlineColor, fillColor)
    @x1 = x1
    @x2 = x2
    @y1 = y1
    @y2 = y2
    @outlineColor = outlineColor
    @fillColor = fillColor
    @parent = parent
    @parent.addRect(self)
  end
  
  def bounds
    java.awt.Rectangle.new(@x1, @y1, (@x2-@x1).abs, (@y2-@y1).abs)
  end  
  
  def remove
    @parent.removeRect(self)
  end
  
  def move(dx, dy)
    @x1 += dx
    @x2 += dx
    @y1 += dy
    @y2 += dy
    @parent.repaint
  end
  
  attr_reader :outlineColor
  attr_reader :fillColor
end

def mainLoop
  java.awt.Frame.getFrames()[0].setVisible(true)
end

def exitProgram
  # a brute force java.lang.System.exit(0) may be required here
  # but the program should terminate if the AWT is halted
  # by disposing all windows
  # and stopping each timer
  # this hopefully plays nicer with (j)irb
  java.awt.Window.getWindows().each {|f| f.dispose}
  TetrisTimer.stopAll
end