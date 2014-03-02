// Generated by CoffeeScript 1.6.3
(function() {
  var Damage, Weapon, WeaponFactory, WeaponTypes;

  Damage = (require('./damage')).Damage;

  Weapon = (function() {
    function Weapon(name, weaponType, damage, extraAttacks) {
      this.name = name;
      this.weaponType = weaponType;
      this.damage = damage;
      this.extraAttacks = extraAttacks;
    }

    return Weapon;

  })();

  WeaponFactory = (function() {
    function WeaponFactory() {}

    WeaponFactory.getClaymore = function() {
      return new Weapon("Claymore", WeaponTypes.sword, new Damage(3, 6, 0), 0);
    };

    WeaponFactory.getBroadSword = function() {
      return new Weapon("Broadsword", WeaponTypes.sword, new Damage(2, 6, 0), 1);
    };

    WeaponFactory.getShortSword = function() {
      return new Weapon("Shortsword", WeaponTypes.sword, new Damage(1, 6, 0), 2);
    };

    WeaponFactory.getMagnum44 = function() {
      return new Weapon("Magnum 44", WeaponTypes.handgun, new Damage(4, 6, 0), 1);
    };

    return WeaponFactory;

  })();

  WeaponTypes = {
    sword: "sword",
    handgun: "handgun",
    rifle: "rifle"
  };

  exports.WeaponFactory = WeaponFactory;

}).call(this);
