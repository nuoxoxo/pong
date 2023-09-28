class Ball {

    constructor() {

        this.x = width / 2  /// Where it starts at : (x, _)
        this.y = height / 2 /// Where it starts at : (_, y)

        // X Displacement should be faster than Y
        this.OriginalXspeed = 9 * Math.cos(random( -PI / 4, PI / 4) )
        this.CurrentXspeed = this.OriginalXspeed 

        this.OriginalYspeed = 9 * Math.cos(random( -PI / 4, PI / 4) )
        this.CurrentYspeed = this.OriginalYspeed 
        this.r = 12
        this.speed = 9
        this.delta = 1.5
        this.Reset() // {}
    }


    Update() {

        // console.log(this.CurrentXspeed, this.CurrentYspeed)

        this.x += this.CurrentXspeed   // Displacement per time unit
        this.y += this.CurrentYspeed
        
    }


    Show() {

        fill(255)
        ellipse(this.x, this.y, this.r * 2)
    }


    Reset() {

        const angle = random(-PI / 4, PI / 4)

        this.x = width / 2
        this.y = height / 2        
        this.CurrentXspeed = this.OriginalXspeed  // 5 * Math.cos(angle)
        this.CurrentYspeed = this.OriginalYspeed  // 5 * Math.sin(angle)

        if (random(1) < 0.5) {
            this.CurrentXspeed *= -1
        }
    }


    HitCeilFloor() {

        if (this.y < 0 || this.y > height) { // touching either Ceil or Floor

            this.CurrentYspeed *= -1 // vector Y mirrors Y-axis while X maintains

            /*
            if (this.y > height) console.log('floor xD')
            if (this.y < 0) console.log('ceil :D')
            */
        }

        if (this.x - this.r > width) { // L wins once |---Dist---> -gt. WindowW 

            LeftScore++
            this.Reset()
        }

        if (this.x + this.r < 0) { // R wins once |---Dist---> -lt. 0

            RightScore++
            this.Reset()
        }
    }


    DoesItHitThePaddleLeft(p) {

        if (
            this.y - this.r < p.y + p.h / 2 &&
            this.y + this.r > p.y - p.h / 2 &&
            this.x - this.r < p.x + p.w / 2
        ) {
            if (this.x <= p.x)
                return
            let diff = this.y - (p.y - p.h / 2)
            let rad = radians(45)
            let angle = map(diff, 0, p.h, -rad, rad)
            this.CurrentXspeed = (this.speed * this.delta) * cos(angle)
            this.CurrentYspeed = (this.speed * this.delta) * sin(angle)
            this.x = p.x + p.w / 2 + this.r
        }
    }


    DoesItHitThePaddleRight (p) {

        if (

            this.y - this.r < p.y + p.h / 2 &&
            this.y + this.r > p.y - p.h / 2 &&
            this.x + this.r > p.x - p.w / 2
        ) {

            if (this.x < p.x) {

                let diff = this.y - (p.y - p.h / 2)
                let angle = map(diff, 0, p.h, radians(225), radians(135))
                this.CurrentXspeed = (this.speed * this.delta) * cos(angle)
                this.CurrentYspeed = (this.speed * this.delta) * sin(angle)
                this.x = p.x - p.w / 2 - this.r
            }
        }
    }


}
