let LeftScore = 0
let RightScore = 0

let isLeft = true
let isRight = !isLeft

let Paddle_SPEED = 21

function setup() {
    createCanvas(900, 600)
    ball = new Ball()
    Left = new Paddle(isLeft)
    Right = new Paddle(isRight)
}

function draw() {
    background('#0f0f0f')
    textFont('Georgia')

    ball.DoesItHitThePaddleRight (Right)
    ball.DoesItHitThePaddleLeft (Left)

    Left.Show()
    Right.Show()
    Left.Update()
    Right.Update()

    ball.Update()
    ball.HitCeilFloor()
    ball.Show()

    fill(255)
    textSize(32)
    text(LeftScore, 128, 40)
    text(RightScore, width - 128, 40)
}


function keyReleased () {

    Left.move(0)
    Right.move(0)
}


function keyPressed () {

    // console.log(key)
    if (keyIsDown(87)) { // UP Left
        Left.move(-Paddle_SPEED)
    }

    if (keyIsDown(83)) { // DOWN Left
        Left.move(Paddle_SPEED)
    }

    if (keyIsDown(73)) { // UP R
        Right.move(-Paddle_SPEED)
    }

    if (keyIsDown(75)) { // DOWN R
        Right.move(Paddle_SPEED)
    }
}

/*
const keyPressed = () => {
    // console.log(key)
    //if (key == "w") {
    if (keyIsDown(87)) {
        Left.move(-Paddle_SPEED)
    // } else if (key == "s") {
    } else if (keyIsDown(83)) {
        Left.move(Paddle_SPEED)
    }

    // if (key == "ArrowUp") {
    if (keyIsDown(UP_ARROW)) {
        Right.move(-Paddle_SPEED)
    // } else if (key == "ArrowDown") {
    } else if (keyIsDown(DOWN_ARROW)) {
        Right.move(Paddle_SPEED)
    }
}
*/
