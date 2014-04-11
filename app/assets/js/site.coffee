openb = angular.module("openb", [])

( ->

	openb.controller("CalculatorController", ($scope, $http) ->
		$scope.expression = "";
		$scope.result = "";
		$scope.success = true;

		$scope.calculate = () ->
			promise = $http.post("/calculate", 
				expression: $scope.expression
			)

			promise.then(
				(response) ->
					$scope.success = true
					$scope.result = response.data.payLoad
					return
				(reason) ->
					$scope.success = false
					$scope.result = reason.data
					return
			)
			return

		return
	)

	return

)()