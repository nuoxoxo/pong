function setup() {
    createCanvas(666, 666);
  }
  
  function draw() {
    background(9)
    noCursor()
    
    // let angle = map(
    //   mouseX,
    //   0, width,
    //   0, 360
    // )
    strokeWeight(mouseX % 83)
    stroke(255, 204, 0)
    line(width / 2, height / 2, mouseX, mouseY)
    
  }
