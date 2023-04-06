class Paddle {
	constructor(isLeft) {
		this.y = height / 2
		this.w = 20
		this.h = 100
		this.ychange = 0
		this.isleft = isLeft

		if (isLeft) {
			this.x = this.w
		} else {
			this.x = width - this.w
		}
	}

	update() {
		this.y += this.ychange
		this.y = constrain(this.y, this.h / 2, height - this.h / 2)
	}

	move(steps) {
		this.ychange = steps
	}

	show() {
		if (this.isleft)
			fill('rgba(0, 255, 0, 0.25)')
		else
			fill('rgba(100%,0%,100%,0.5)')
		rectMode(CENTER)
		rect(this.x, this.y, this.w, this.h)
	}
}

