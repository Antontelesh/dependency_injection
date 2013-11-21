describe 'Dependency Injection Class', ->
	beforeEach ->
		DI.removeAll()

	it 'should register new module', ->
		DI.module 'test_module', ->
		expect(DI.getModuleByName('test_module').name).toBe 'test_module'

	it 'should return false if module doesnt\'t exist', ->
		expect(DI.getModuleByName('test_module')).toBe false


	it 'should remove module', ->
		DI.module 'test_module', ->
			return true

		expect(DI.getModuleByName('test_module').name).toBe 'test_module'
		DI.removeModule 'test_module'
		expect(DI.getModuleByName('test_module')).toBe false

	it 'should remove all modules', ->
		DI.module 'module 1', ->
			return 'module 1'

		DI.module 'module 2', ->
			return 'module 2'

		DI.removeAll()
		expect(DI.getModules()).toEqual []


	it 'should execute module after all its dependencies have been executed', ->
		executions = []

		DI.module 'dependent module', [
			'independent module'
			->
				executions.push 'dependent'
		]

		DI.module 'independent module', ->
			executions.push 'independent'

		expect(executions).toEqual ['independent', 'dependent']



		executions = []
		DI.module 'module1', [
			'module2'
			'module3'
			->
				executions.push 'module1'
		]

		DI.module 'module2', [
			'module3'
			->
				executions.push 'module2'
		]

		DI.module 'module3', ->
			executions.push 'module3'

		expect(executions).toEqual ['module3','module2','module1']


	it 'should pass dependencies to dependent function', ->
		passed_arguments = []
		DI.module 'module 1', [
			'module 2'
			'module 3'
			(mod2, mod3) ->
				passed_arguments.push mod2
				passed_arguments.push mod3
		]

		DI.module 'module 2', [
			'module 3'
			(mod3) ->
				passed_arguments.push mod3
				return 'mod2'
		]

		DI.module 'module 3', ->
			'mod3'

		expect(passed_arguments).toEqual ['mod3','mod2','mod3']


