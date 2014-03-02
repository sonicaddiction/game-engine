Damage = (require './damage').Damage

class Weapon
    constructor: (@name, @weaponType, @damage, @extraAttacks) ->

class WeaponFactory
    constructor: () ->

    @getClaymore: ->
        new Weapon("Claymore", WeaponTypes.sword, new Damage(3, 6, 0), 0)

    @getBroadSword: ->
        new Weapon("Broadsword", WeaponTypes.sword, new Damage(2, 6, 0), 1)

    @getShortSword: ->
        new Weapon("Shortsword", WeaponTypes.sword, new Damage(1, 6, 0), 2)

    @getMagnum44: ->
        new Weapon("Magnum 44", WeaponTypes.handgun, new Damage(4, 6, 0), 1)

WeaponTypes =
    sword: "sword"
    handgun: "handgun"
    rifle: "rifle"


exports.WeaponFactory = WeaponFactory