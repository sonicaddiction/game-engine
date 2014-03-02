log = (require './log').log
SkillFactory = (require "./skill").SkillFactory
StatusEffects = (require "./statuseffects").StatusEffects
StatusEffectsFactory = (require "./statuseffects").StatusEffectsFactory

class Agent
    constructor: (@name, @maxHitpoints, @actions) ->
        @hitpoints = @maxHitpoints
        @mainWeapon = null

        @skills =
            sword: SkillFactory.getSwordSkill()
            initiative: SkillFactory.getInitiative()
            toughness: SkillFactory.getToughness()

        @statusEffects = []

    speak: ->
        log "My name is #{ @name }"

    listSkills: ->
        for skill, value of @skills
            log "#{ skill }: #{ value }"

    setMainWeapon: (weapon) ->
        @mainWeapon = weapon

    getSkillForMainWeapon: ->
        @skills[@mainWeapon.weaponType]

    isAffectedByStatusEffect: (statusEffect) ->
        @statusEffects[statusEffect]

    setStunned: (duration) ->
        @statusEffects[StatusEffects.stunned] = StatusEffectsFactory.getStunned(duration)

    unsetStunned: ->
        @statusEffects[statusEffects.stunned]?.cure()

    isStunned: ->
        return @statusEffects[StatusEffects.stunned]?.isActive()

    setDead: () ->
        @statusEffects[StatusEffects.dead] = StatusEffectsFactory.getDead(-1)

    unsetDead: ->
        @statusEffects[statusEffects.dead]?.cure()

    isDead: ->
        return @statusEffects[StatusEffects.dead]?.isActive()

    countDownStatuses: ->
        for name, statusEffect of @statusEffects
            statusEffect.countDown()

    isAlive: ->
        not @isDead()

exports.Agent = Agent
