log = (require './log').log
WeaponFactory = (require './weapon').WeaponFactory
Agent = (require './agent').Agent

class AgentFactory
    constructor: ->

    @getKnight: (name) ->
        agent = new Agent(name, 15, 1)

        agent.skills.sword.setSkillLevel 13
        agent.skills.initiative.setSkillLevel 10
        agent.skills.toughness.setSkillLevel 13

        agent.setMainWeapon WeaponFactory.getBroadSword()

        return agent

    @getHighlander: (name) ->
        agent = new Agent(name, 18, 1)

        agent.skills.sword.setSkillLevel 13
        agent.skills.initiative.setSkillLevel 10
        agent.skills.toughness.setSkillLevel 15

        agent.setMainWeapon WeaponFactory.getClaymore()

        return agent

    @getMilita: (name) ->
        agent = new Agent(name, 12, 1)

        agent.skills.sword.setSkillLevel 10
        agent.skills.initiative.setSkillLevel 8
        agent.skills.toughness.setSkillLevel 8

        agent.setMainWeapon WeaponFactory.getShortSword()

        return agent

    @getRogue: (name) ->
        agent = new Agent(name, 9, 2)

        agent.skills.sword.setSkillLevel 17
        agent.skills.initiative.setSkillLevel 14
        agent.skills.toughness.setSkillLevel 8

        agent.setMainWeapon WeaponFactory.getShortSword()

        return agent


exports.AgentFactory = AgentFactory