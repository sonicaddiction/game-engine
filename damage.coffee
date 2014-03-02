class Damage
    constructor: (@numberOfRolls, @diceSides, @modification = 0) ->

    roll: ->
        sum = 0
        for n in [1..@numberOfRolls]
            sum += Math.ceil(Math.random() * @diceSides) + @modification
        return sum

exports.Damage = Damage