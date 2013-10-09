import spock.lang.*

import org.MyClass

class HelloSpock extends spock.lang.Specification {
    @Unroll
    def "length of #name is #length"() {
    expect:
        name.size() == length

    where:
        name     | length
        "Spock"  | 5
        "Kirk"   | 4
        "Scotty" | 6
    }

    @Unroll
    def "MyClass doubles #num to #res"() {
    expect:
        new MyClass().double(num) == res
    where:
        num | res
        0   | 0
        -1  | -2
        4   | 8
    }

    @Unroll
    def "MyClass doubles #num to #res"() {
    expect:
        new MyClass().double(num) == res
    where:
        num = Math.random()
        res = 2 * num
    }

}