class CommandsController < ApplicationController
  @@validDirections = 'NSEW'
  
  @@northDirection = 'N'
  @@southDirection = 'S'
  @@eastDirection = 'E'
  @@westDirection = 'W'

  @@validCommands = 'LRM'

  @@leftCommand = 'L'
  @@rightCommand = 'R'
  @@moveCommand = 'M'
  
  @@tests = []
  @@items = []

  def doMove
    if (@direction == @@northDirection)
      @ptY = @ptY + 1
    elsif (@direction == @@eastDirection)
      @ptX = @ptX + 1
    elsif (@direction == @@southDirection)
      @ptY = @ptY - 1
    elsif (@direction == @@westDirection)
      @ptX = @ptX - 1
    end
  end
  
  def doSpin(d)
    @direction = ( (@@validDirections.index(d)) or (@@validCommands.index(d)) ) ? d : @direction
  end
  
  def doCommand(c)
    if (c == @@leftCommand)
      if (@direction == @@northDirection)
        doSpin(@@westDirection)
      elsif (@direction == @@westDirection)
        doSpin(@@southDirection)
      elsif (@direction == @@southDirection)
        doSpin(@@eastDirection)
      elsif (@direction == @@eastDirection)
        doSpin(@@northDirection)
      end
    else
      if (c == @@rightCommand)
        if (@direction == @@northDirection)
          doSpin(@@eastDirection)
        elsif (@direction == @@eastDirection)
          doSpin(@@southDirection)
        elsif (@direction == @@southDirection)
          doSpin(@@westDirection)
        elsif (@direction == @@westDirection)
          doSpin(@@northDirection)
        end
      elsif (c == @@moveCommand)
        doMove
      end
    end
  end
  
  def parseCommand(c)
    if @@validCommands.index(c)
      doCommand(c)
    else
      toks = c.split()
      toks.length.times do |i|
        aTok = toks[i]
        if aTok.length > 1
          aTok.length.times do |i|
            aCmd = aTok[i, 1]
            doCommand(aCmd)
          end
        else
          n = aTok.to_f
          b = n > 0
          if (b)
            @@tests.push(b)
            @@items.push(aTok)
            if ( (@@tests.length == 2) && (@@tests[0] == true) && (@@tests[1] == true) )
              @ptX = @@items.shift().to_i
              @ptY = @@items.shift().to_i
              b = @@tests.shift()
              b = @@tests.shift()
            end
          elsif @@validDirections.index(aTok)
            @direction = aTok
          elsif @@validCommands.index(aTok)
            doCommand(aTok)
          end
        end
      end
    end
  end
  
  def index
    @ptX = 0
    @ptY = 0
    @direction = ''
    @commands = [{:x => @ptX,:y => @ptY,:direction => @direction}]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @commands }
    end
  end

  def show
    p = @_request.parameters()
    @ptX = p[:ptX].to_i
    @ptY = p[:ptY].to_i
    @direction = p[:direction]
    cmd = p[:command]

    if (cmd)
      parseCommand(cmd)
    end

    @commands = [{:x => @ptX,:y => @ptY,:direction => @direction}]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @command }
    end
  end
end
