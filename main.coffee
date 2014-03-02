AgentFactory = (require './agent_factory').AgentFactory
Engine = (require './engine').Engine
Attack = (require './action').Attack
Block = (require './action').Block
log = (require './log').log

results =
    kristofer: 0
    mazlach: 0
    roundLength: 0


runBattle = (results) ->
    bothAlive = ->
        kristofer.isAlive() and mazlach.isAlive()

    roundLength = 0
    engine = new Engine

    kristofer = AgentFactory.getKnight "Kristofer"
    mazlach = AgentFactory.getKnight "Mazlach"

    engine.addAgent kristofer
    engine.addAgent mazlach

    engine.listAgents()

    #while bothAlive()

    #Setup the round
    engine.setupRound()

    #Add the actions
    engine.addAction(new Attack(kristofer, mazlach))
    engine.addAction(new Attack(kristofer, mazlach))
    engine.addAction(new Attack(kristofer, mazlach))

    engine.addAction(new Block(mazlach, kristofer))

    #Resolve the round
    engine.resolveRound()
    roundLength++

    ###
    results.roundLength += roundLength

    if kristofer.isAlive()
        results.kristofer += 1
    else if mazlach.isAlive()
        results.mazlach += 1
    else
        results.draw += 1
    ###

loops = 1;

for i in [1..loops]
    runBattle(results)

results.roundLength /= loops

console.log results