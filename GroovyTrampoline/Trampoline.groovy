def max
max = { it ->
    def tail = it.tail()
    if (!tail) {
        return it[0]
    } else {
        def val = max(tail)
        return (it[0] > val ? it[0] : val)
    }
}
def values = (1..1e6).collect{ Math.random() }
println "max(values)=${max(values)}"
System.exit(0)

def factorial
factorial = {
    it <= 1 ? 1G : it * factorial(it - 1)
}
//println "factorial(500G) = ${factorial(500G)}" //stack overflow

factorial = {it, acc = 1->
    it <= 1 ? acc : factorial.trampoline(it - 1, it * acc)
}.trampoline()
println "factorial(500G) = ${factorial(500G)}" //no stack overflow

def pong
def ping = { counter ->
    println 'ping ' + counter
    counter <= 0 ? 'STOP' : pong.trampoline(counter-1)
}.trampoline()

pong = { counter ->
    println 'pong ' + counter
    ping.trampoline(counter)
}.trampoline()

println ping(10)