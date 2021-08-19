output stringOutput string = deployment().name
output integerOutput int = length(environment().authentication.audiences)
output booleanOutput bool = contains(deployment().name, 'demo')
output arrayOutput array = environment().authentication.audiences
output objectOutput object = subscription()
