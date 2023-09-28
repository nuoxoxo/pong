let leftscore = 0
let rightscore = 0
let paddle_speed = 21

function setup() {
    createCanvas(1200, 800)
    ball = new Ball()
    left = new Paddle(true)
    right = new Paddle(false)
}

function draw() {
    background(0)

    ball.checkPaddleRight(right)
    ball.checkPaddleLeft(left)

    left.show()
    right.show()
    left.update()
    right.update()

    ball.update()
    ball.edges()
    ball.show()

    fill(255)
    textSize(32)
    text(leftscore, 32, 40)
    text(rightscore, width - 64, 40)
}

function keyReleased() {
    left.move(0)
    right.move(0)
}

function keyPressed() {
    console.log(key)
    if (key == "w") {
        left.move(-paddle_speed)
    } else if (key == "s") {
        left.move(paddle_speed)
    }

    if (key == "ArrowUp") {
        right.move(-paddle_speed)
    } else if (key == "ArrowDown") {
        right.move(paddle_speed)
    }
}

