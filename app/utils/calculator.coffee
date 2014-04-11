mongojs = require("mongojs")

db = mongojs("openb_calc")
collection = db.collection("history")

module.exports = (app) ->
	
	Calculator = 

		###
		# Define operator priority and the math operation
		###
		operations:
			"+": 
				priority: 0
				fn: (op1, op2) ->
					return op1 + op2
			"-": 
				priority: 0
				fn: (op1, op2) ->
					return op1 - op2
			"*": 
				priority: 1
				fn: (op1, op2) ->
					return op1 * op2
			"/": 
				priority: 1
				fn: (op1, op2) ->
					return op1 / op2

		###
		# Temporary holder for current expression
		###
		expression: null

		###
		# Temporary holder for all numbers in an expression
		###
		numbers: []

		###
		# Temporary holder for all operators in an expression
		###
		operators: []

		###
		# Temporary holder for all steps involved in an expression evaluation
		###
		steps: []

		###
		# Start evaluating an expression
		###
		run: (expression) ->
			unless expression
				return 0

			# for record purpose
			@expression = expression

			# strip all whitespaces
			expression = expression.replace(/\s/g, "")

			# make copies
			forNum = expression
			forOperators = expression

			# adapted from http://stackoverflow.com/a/17051607/940030
			numbers = @numbers = forNum.split(/[^0-9\.]+/)
			operators = @operators = forOperators.replace(/[0-9]+/g, "#").replace(/[\(|\|\.)]/g, "").split("#").filter(
				(n) ->
					n
			);

			# eval
			result = @operate(numbers.shift(), numbers.shift())

			# record
			@record()

			return result

		###
		# A recursive function that'll prioritize * and / operations ahead of + and -
		###
		operate: (op1, op2) ->
			unless op2
				return op1

			operator = @operators.shift()
			operation = @operations[operator]

			# + or -
			if operation.priority == 0
				op2 = @operate(op2, @numbers.shift())

			@steps.push("#{op1} #{operator} #{op2}")

			operationResult = @parseNum(operation.fn(@parseNum(op1), @parseNum(op2)))

			return @operate(operationResult, @numbers.shift())

		###
		# Parse numbers to precision of 3 (0.00)
		###
		parseNum: (str) ->
			num = new Number(str)
			return parseFloat(num.toPrecision(3))

		record: () ->
			if !collection or !@expression or !@steps
				return

			console.log("Recording history for '#{@expression}': #{@steps}...")

			collection.insert(
				expression: @expression,
				steps: @steps.join(" & ")
			, (error) ->
				return console.error(error) if error
			)