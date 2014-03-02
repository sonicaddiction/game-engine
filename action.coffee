class Action
    @name
    constructor: (@performer) ->
    setPriority: (@priority) ->


class Attack extends Action
    constructor: (@attacker, @defender) ->
        @performer = @attacker
        @name = "attack"

class Block extends Action
    constructor: (@blocker, @attacker) ->
        @performer = @blocker
        @name = "block"


exports.Attack = Attack
exports.Block = Block