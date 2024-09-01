import express from 'express'
const app = express()
const port = 8080

console.log("Server Start")

app.get('/hello', (_, res) => {
    console.log('Recive Hello')
    res.send('Hello Stormwork HTTP!!')
})
app.get('/calc', (req, res) => {
    console.log('Request Calc')
    let x1 = Number(req.query.x[0])
    let y1 = Number(req.query.y[0])
    let x2 = Number(req.query.x[1])
    let y2 = Number(req.query.y[1])
    console.log(`Pos1 x:${x1} y:${y1} Pos2 x:${x2} y:${y2}`)
    let disntace = calcDistance(x1, y1, x2, y2)
    console.log(`Result: ${disntace}`)
    res.send(String(disntace))
})
app.listen(port)

function calcDistance(x1, y1, x2, y2) {
    return Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)
}