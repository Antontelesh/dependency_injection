class Module
	constructor: (@name, dependencies = []) ->
		dependencies = [dependencies] if typeof dependencies == 'function'
		@code = dependencies.pop()
		@dependencies = dependencies
	executed: false
	run: ->
		dep_instances = []
		for dependency in @dependencies
			dep_instance = DI.getModuleByName dependency
			dep_instances.push dep_instance.result

		if @code?
			@result = @code.apply this, dep_instances
			@executed = true
			return @result
		return false

class @DI
	modules = []
	self = @

	_getModule = (name, where) ->
		for module in where
			return module if module.name == name
		false


	@getQueuedModules: ->
		result = []
		for module in modules
			if !module.executed
				result.push module
		result

	@getExecutedModules: ->
		result = []
		for module in modules
			if module.executed
				result.push module
		result

	@getModules: ->
		modules

	_checkIfAllDepsExecuted = (module) ->
		executed = self.getExecutedModules()

		for dep in module.dependencies
			if !_getModule dep, executed
				return false
		true

	_run = ->
		queue = self.getQueuedModules()

		for module in queue
			all_deps_executed = _checkIfAllDepsExecuted module
			if all_deps_executed
				module.run()
				_run()
				break

	@getModuleByName: (name) ->
		_getModule name, modules


	@module: (name, dependencies = []) ->
		if !@getModuleByName name
			module = new Module name, dependencies
			modules.push module
			_run()

	@removeModule: (name) ->
		for module, index in modules
			if module.name == name
				modules.splice index, 1
				return true
		return false


	@removeAll: ->
		modules = []
