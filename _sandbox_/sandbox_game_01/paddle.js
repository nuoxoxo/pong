class Paddle {

    constructor(isLeft) {

        this.x = undefined
        this.y = height / 2
        this.w = 21
        this.h = 112
        this.deltaY = 0
        this.offset = this.h / 2 - random() * 3
        this.isleft = isLeft

        if (isLeft) {
            this.x = this.w
        } else {
            this.x = width - this.w
        }
    }


    Update() {

        this.y += this.deltaY
        this.y = constrain(
            this.y, 
            this.h - this.offset , 
            height - this.h + this.offset
        )
    }


    MoveVertically(SPEED) {

        this.deltaY = SPEED
    }


    Show() {

        fill(
            this.isleft
            ? 'rgba(0, 255, 0, 0.25)'
            : 'rgba(100%, 0%, 100%, 0.5)'
        )

        rectMode(CENTER)
        rect(this.x, this.y, this.w, this.h)
    }
}

