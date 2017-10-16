# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require underscore
#= require hammer
#= require paper-full

class window.ColoringInteraction
    @COLORING_PAGE: "/coloringpages/pluto.svg"
    constructor: (options)->
        scope = this
        Utility.paperSetup "paperCanvas"
        # SETUP COLOR PALETTE
        # IMPORT COLORING PAGE
        paper.project.importSVG ColoringInteraction.COLORING_PAGE, (svg)->
            svg.position = paper.view.center
            
        # $("canvas").click ->
        #     console.log "hi"
            
            # COMMENT OUT ONE OF THESE TO TOGGLE BETWEEN INTERACTIONS
            #scope.myGradientInteraction()
            scope.myCustomInteraction()
            
    myGradientInteraction: ()->     
        hitOptions = 
            segments: false
            stroke: false
            fill: true
            tolerance: 5
            
        # IMPLEMENT GRADIENT COLOR HERE
        size = new Size(200, 200);
        rect = new Path.Rectangle({
            point: paper.view.center.add(new Point(-100, -100)),
            size : size,
            strokeColor : 'black',
        });

        
        t = new paper.Tool
        t.minDistance = 10
        mouseDownEvent = new Point 
        
        
        
        t.onMouseDown =  (event)->
            mouseDownEvent = event.point
            hitResult = paper.project.hitTest(event.point, hitOptions)
            if not hitResult then return
            _.each hitResult, (hit)->
                # DON'T COLOR THE BLACK LINES
                if hit.fillColor and hit.fillColor.equals("black") then return;
                hit.fillColor = cp.currentColor()

        t.onMouseDrag =  (event)->
            # MOUSE DRAG ACTION
        t.onMouseUp =  (event)->
            rect.fillColor = {
                gradient : {
                    stops: cp.history
                },
                origin: mouseDownEvent,
                destination: event.point 
            }
      
        
        
    #THIS IS WHERE YOUR CUSTOM INTERACTION WILL BE GOING    
    myCustomInteraction: ()->    
        pal = new Group
        dp = new Point
        trace = new Path()
        drawing = new Path()
        onSide = false
        clrs = []
        trace.strokeColor = 'black'
        selectedColor = 'white'
        hitOptions = 
            segments: false
            stroke: false
            fill: true
            tolerance: 5
        path = new Path()
        # IMPLEMENT GRADIENT COLOR HERE
        t = new paper.Tool
        t.minDistance = 1
        paletteColors = (color, point)->
            col = new paper.Path.Circle
                radius : 12
                fillColor : color
                center: point
                strokeColor: 'black'
                parent: pal
                
            pal.addChild(col)
            return col 
        circleMaker = (center, radius)->
            c = new Path.Circle
                radius: radius
                center: center
                strokeColor: selectedColor
                fillColor: selectedColor
            
        t.onMouseDown =  (event)->
            dp = event.downPoint
            hitResult = paper.project.hitTest(event.point, hitOptions)
            if not hitResult
                onSide = true
                clrs = {'red': dp.add(new Point(-28.284, 28.284)), 'black': dp.add(new Point(0, 40)), 'white': dp.add(new Point(0, -40)), 'blue': dp.add(new Point(28.284, 28.284)), 'cyan': dp.add(new Point(40, 0)), 'green': dp.add(new Point(28.284, -28.284)), 'yellow': dp.add(new Point(-28.284, -28.284)), 'orange': dp.add(new Point(-40, 0))} 
                hues = _.flatten [new paper.Color("white"), hues, new paper.Color("black")]
                bottomLeft = paletteColors('red', clrs['red'])
                bottom = paletteColors('black', clrs['black'])
                bottomRight = paletteColors('blue', clrs['blue'])
                right = paletteColors('cyan', clrs['cyan'])
                topRight = paletteColors('green', clrs['green'])
                top = paletteColors('white', clrs['white'])
                topLeft = paletteColors('yellow', clrs['yellow'])
                left = paletteColors('orange', clrs['orange'])
                
                
    
                palOutline = new paper.Path.Circle
                    radius : 60
                    fillColor : 'grey'
                    strokeColor : 'black'
                    parent: pal
                    center: event.point
    
                palCenter = new paper.Path.Circle 
                    center: event.point
                    radius : 15
                    fillColor : 'white'
                    strokeColor : 'black'
                    parent: pal
    
                    
                pal.children = [palOutline, palCenter, topLeft, top, topRight, right, bottomRight, bottom, bottomLeft, left]
            else 
                onSide = false
                currPt = circleMaker(event.point, 12 * paper.view.zoom)
                

            
            

                
               
        t.onMouseDrag =  (event)->
            if onSide
                trace.removeSegment(0)
                trace.removeSegment(0)
                trace.add(dp)
                trace.add(event.point)
            else 
                lstPt = circleMaker(event.downPoint, 12)
                prevPt = circleMaker(event.middlePoint, 12)
                currPt = circleMaker(event.point, 12)
                
            
            
            
        t.onMouseUp =  (event)->
            if onSide
                console.log("event.point")
                console.log(event.point)
                trace.removeSegment(0)
                trace.removeSegment(0)
                for key in Object.keys(clrs)
                    console.log("key is")
                    console.log(key)
                    console.log("Value is")
                    console.log(clrs[key])
                    console.log("distance is:")
                    distance = event.point.getDistance(clrs[key])
                    console.log(distance)
                    if distance <= 12
                        selectedColor = key
                        console.log("selected color is")
                        console.log(selectedColor)
                pal.children = []
                hitResult = paper.project.hitTest(event.point, hitOptions)
                _.each hitResult, (hit)->
                        if hit.fillColor and hit.fillColor.equals("black")
                            return
                        else
                            if hit.fillColor and hit.fillColor.equals("black")
                                hit.fillColor = selectedColor
                                console.log("HELLLOOO MOUSE UPS")
            else 
                currPt = circleMaker(event.point, 12)
                            
        
