###
  Tänket är att man har ett visst antal handlingar per rond.
  Man får reda på sitt initiativvärde och kan därefter välja hur man vill spendera sina handlingar.
  Om man får en skada och misslyckas med ett motståndsslag förlorar man resterande handlingar.
  Om man får en skada försämras initiativvärdet inför kommande rond.
  Om man får högre initiativ som blockerare blir blockeringen lättare och det finns en chans för ripost
###

log = (require './log').log
Attack = (require './action').Attack
Block = (require './action').Block

_ = require "lodash"

class Engine
    constructor: ->
        @agents = []
        @actionList = []
        @blockList = []
        @attackList = []

    addAgent: (agent) ->
        @agents.push agent

    getAgent: (index) ->
        return @agents[index]

    listAgents: ->
        for agent, index in @agents
            statuses = []
            for name, statusEffect of agent.statusEffects
                if statusEffect.isActive() then statuses.push statusEffect.name

            log "Agent #{ index }: #{ agent.name }, HP: #{ agent.hitpoints }, Statuses: #{ statuses.join(", ") }"


    addAction: (action) ->
        action.setPriority action.performer.skills.initiative.skillCheckDiff()
        @actionList.push action
        @actionList = _.sortBy(@actionList, (_action) -> _action.priority).reverse()

    listActions: ->
        log "***"
        for action in @actionList
            log action.priority + "\t" + action.performer.name + "\t" + action.name
        log "***"

    hit: (attack) ->
        attacker = attack.attacker
        defender = attack.defender
        damage = attacker.mainWeapon.damage.roll()

        defender.hitpoints -= damage
        log "#{ defender.name } is hit for #{ damage } hp and has #{ defender.hitpoints } hp left"

        if defender.hitpoints < 0
            defender.setDead()
            log "#{ defender.name } dies from the wounds"
            return

        #if recieve to much damage then loose remaining actions
        toughEnough = defender.skills.toughness.skillCheckVs(damage)

        if toughEnough
            log "#{ defender.name } just shakes the damage off"
        else
            defender.setStunned(1)
            log "#{ defender.name } takes a bit to much damage and looses remaining actions"

    singleBlock: (attack) ->


    attack: (attack) ->
        attacker = attack.attacker
        defender = attack.defender

        if attacker.isDead()
            log "#{ attacker.name } is dead."
            return

        if defender.isDead()
            log "#{ defender.name } is dead."
            return

        if attacker.isStunned()
            log "#{ attack.attacker.name } is stunned and can not attack"
            return

        log "#{ attack.attacker.name } attacks #{ attack.defender.name }"
        successfulAttack = attacker.getSkillForMainWeapon().skillCheck()

        block = @popEligibleBlocks(attack)
        if block and not defender.isStunned()
            successfulBlock = defender.getSkillForMainWeapon().skillCheck()

        if successfulAttack and not successfulBlock
            @hit(attack)
        else if successfulAttack and successfulBlock
            log "#{ defender.name } blocks the attack"
        else if successfulBlock and not successfulAttack
            log "#{ defender.name } blocks a failed attack and gains some initiative"
        else
            log "Both #{ attacker.name } and #{ defender.name } stumble around clumsily"

    popEligibleBlocks: (attack) ->
        block =_.find @blockList, (block, index) =>
            if block.blocker is attack.defender
                @blockList.splice(index, 1)
                return true

        return block

    resolveRound: ->
        @listActions()
        for action in @actionList
            switch action.name
                when 'attack' then @attackList.push action
                when 'block' then @blockList.push action

        for attack in @attackList
            @attack(attack)

    setupRound: ->
        @actionList = []
        @blockList = []
        @attackList = []

        for agent in @agents
            agent.countDownStatuses()

exports.Engine = Engine
exports.Attack = Attack
exports.Block = Block