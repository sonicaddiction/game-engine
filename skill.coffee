log = (require './log').log

class Skill
    constructor: (@name) ->
        @skillLevel = 0

    setSkillLevel: (@skillLevel) ->

    percentageRoll: ->
        Math.random()

    d20roll: ->
        Math.ceil(Math.random() * 20)

    d10roll: ->
        Math.ceil(Math.random() * 10)

    skillCheck: (modification = 0,
                 roll = @d20roll()) ->
        requirement = @skillLevel + modification
        log "Skillcheck for #{ @name }: Requirement = #{ requirement }, Roll = #{ roll }"
        roll <= requirement

    skillCheckVs: (difficulty,
                   roll = @d20roll()) ->
        diff = @skillLevel - difficulty
        requirement = 10 + diff
        log "Skillcheck for #{ @name }: Requirement = #{ requirement }, Roll = #{ roll }"
        roll <= requirement

    skillCheckDiff: (modification = 0, roll = @d20roll()) ->
        actualSkill = @skillLevel + modification
        log "Skillcheck for #{ @name }: Actual skill: #{ actualSkill } - Roll: #{ roll } = #{ actualSkill - roll }"
        actualSkill - roll

class SkillFactory
    constructor: ->

    @getSwordSkill: ->
        new Skill("sword")

    @getToughness: ->
        new Skill("toughness")

    @getInitiative: ->
        new Skill("initiative")

exports.Skill = Skill
exports.SkillFactory = SkillFactory