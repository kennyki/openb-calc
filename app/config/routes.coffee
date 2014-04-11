module.exports = (app) ->
	{pathRaw} = app.locals.path
	{Calculator} = app.locals

	app.get pathRaw('index'), (req, res) ->
		res.render 'index', view: 'index'

	app.post "/calculate", (req, res) ->
		expression = req.body.expression

		if expression
			res.json(
				payLoad: Calculator.run(expression)
			)
		else
			res.error(
				reason: "Parameter 'expression' is undefined."
			)