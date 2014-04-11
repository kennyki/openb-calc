app = require '../app'

{Calculator} = app.locals

describe "Calculator", ()->
	
	it "can eval addition", ()->
		Calculator.run("1+1+2").should.equal 4

	it "can eval with spaces before/between/after operators and operands", ()->
		Calculator.run(" 1 +  1+2   ").should.equal 4

	it "can eval floating point numbers", ()->
		Calculator.run("1.1 + 1.2").should.equal 2.3

	it "can eval with spaces between numbers and decimal of a floating point", ()->
		Calculator.run(" 1 . 1 +  1   .    2   ").should.equal 2.3

	it "can eval floating point numbers to precision of 3", ()->
		Calculator.run("1.11 + 1.200003").should.equal 2.31

	it "can eval subtraction", ()->
		Calculator.run("1.1003 - 1.002").should.equal 0.1

	it "can eval multiplication", ()->
		Calculator.run("1.1 * 2.003").should.equal 2.2

	it "can eval division", ()->
		Calculator.run("1.003 / 2.0001").should.equal 0.5
	
	it "should eval multiplication or division before addition or subtraction", ()->
		Calculator.run("1 + 2 * 3 / 2 + 1").should.equal 5
