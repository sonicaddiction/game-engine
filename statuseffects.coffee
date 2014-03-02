class StatusEffect
    constructor: (@name, @duration) ->

    countDown: ->
        if @duration > 0
            @duration--

    addToDuration: (time) ->
        @duration += time

    isActive: ->
        @duration isnt 0

    cure: ->
        @duration = 0

class StatusEffectsFactory
    constructor: () ->

    @getStunned: (duration) ->
        new StatusEffect(StatusEffects.stunned, duration)

    @getDead: () ->
        new StatusEffect(StatusEffects.dead, -1)

StatusEffects =
    stunned: "stunned"
    dead: "dead"

exports.StatusEffects = StatusEffects
exports.StatusEffectsFactory = StatusEffectsFactory