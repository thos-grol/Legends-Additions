//"Schrat Symbiosis";
//"With the proper concoction and implanting the heart of schrat into the body, the test subject can form a symbiosis with the heart, gaining the abilities and properties of a schrat. They can send tendrils of wood out of their body.";
::mods_hookExactClass("skills/effects/schrat_potion_effect", function (o)
{
    o.create = function()
    {
        this.m.ID = "effects.schrat_potion";
		this.m.Name = "Schrat Symbiosis";
		this.m.Icon = "skills/status_effect_146.png";
		this.m.IconMini = "status_effect_146_mini";
		this.m.Overlay = "status_effect_146";
        this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
    }

    o.getDescription = function()
    {
        return "With the proper concoction and implanting the heart of schrat into the body, the test subject can form a symbiosis with the heart, gaining the abilities and properties of a schrat. They can send tendrils of wood out of their body.";
    }

    o.getTooltip = function()
    {
        local ret = [
            {
                id = 1,
                type = "title",
                text = this.getName()
            },
            {
                id = 2,
                type = "description",
                text = this.getDescription()
            },
            {
                id = 11,
                type = "text",
                icon = "ui/icons/armor_body.png",
                text = "Greatly reduces any form of piercing damage, but you take 33% more burning damage."
            }
        ];

        if (this.getContainer().getActor().getFlags().has("schrat_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "When taking damage more than or equal to 15% of your health, birth a minature greenwood schrat from your blood and surroundings to help you in combat."
            });
        }

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Immune to being knocked back or grabbed"
        });

        ret.push({
            id = 12,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
        });

        return ret;
    }

    o.onUpdate = function(_properties)
    {
        _properties.IsImmuneToKnockBackAndGrab = true;

        if (this.getContainer().getActor().getFlags().has("schrat_8"))
        {
            if (!this.m.Container.hasSkill("actives.uproot"))
            {
                this.m.Container.add(::new("scripts/skills/actives/uproot_skill"));
            }
        }

    }

    o.onRemoved <- function()
    {
        if (this.getContainer().getActor().getFlags().has("schrat_8")) this.m.Container.removeByID("actives.uproot");
    }

    o.onBeforeDamageReceived <- function(_attacker, _skill, _hitInfo, _properties)
    {
        if (_skill == null) return;

        switch(_hitInfo.DamageType)
        {
            case ::Const.Damage.DamageType.Piercing:
                if (_skill == null) _properties.DamageReceivedRegularMult *= 0.25;
                else if (_skill.isRanged())
                {
                    local weapon = _skill.getItem();

                    if (weapon != null && weapon.isItemType(::Const.Items.ItemType.Weapon))
                    {
                        if (weapon.isWeaponType(::Const.Items.WeaponType.Bow) || weapon.isWeaponType(::Const.Items.WeaponType.Crossbow)) _properties.DamageReceivedRegularMult *= 0.25;
                        else if (weapon.isWeaponType(::Const.Items.WeaponType.Throwing)) _properties.DamageReceivedRegularMult *= 0.5;
                        else _properties.DamageReceivedRegularMult *= 0.5;
                    }
                    else _properties.DamageReceivedRegularMult *= 0.2;
                }
                break;

            case ::Const.Damage.DamageType.Burning:
                _properties.DamageReceivedRegularMult *= 1.33;
                break;
        }
    }

    o.onDamageReceived <- function(_attacker, _damageHitpoints, _damageArmor)
    {
        local actor = this.getContainer().getActor();
        if (actor.getFlags().has("schrat_8") && _damageHitpoints >= actor.getHitpointsMax() * 0.25)
        {
            local candidates = [];
            local myTile = actor.getTile();

            for( local i = 0; i < 6; i = i )
            {
                if (myTile.hasNextTile(i))
                {
                    local nextTile = myTile.getNextTile(i);
                    if (nextTile.IsEmpty && this.Math.abs(myTile.Level - nextTile.Level) <= 1) candidates.push(nextTile);
                }
                i = ++i;
            }

            if (candidates.len() != 0)
            {
                local spawnTile = candidates[this.Math.rand(0, candidates.len() - 1)];
                local sapling = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_greenwood_schrat_small", spawnTile.Coords);
                sapling.setFaction(actor.getFaction() == ::Const.Faction.Player ? ::Const.Faction.PlayerAnimals : actor.getFaction());
                sapling.riseFromGround();
            }
        }
    }

});

::mods_hookExactClass("skills/actives/uproot_skill", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.FatigueCost = 40;
    }

    o.onUpdate = function(_properties)
    {
        local _actor = this.getContainer().getActor();

        if (_actor.getFaction() != ::Const.Faction.PlayerAnimals && _actor.getFaction() != ::Const.Faction.Player)
        {
            _properties.DamageRegularMin += 70;
            _properties.DamageRegularMax += 100;
        }
        _properties.DamageArmorMult *= 0.85;
    }
});