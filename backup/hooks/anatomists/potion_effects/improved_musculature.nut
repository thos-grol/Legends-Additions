//"Improved Musculature";
//"This character\'s wrists have mutated in such a way that the they dampen the initial shock of opposing forces. In more practical terms, they reduce the protective qualities of an enemy\'s armor when struck. They can also make some pretty outlandish shadow puppets.";
::mods_hookExactClass("skills/effects/orc_young_potion_effect", function (o)
{
    o.create = function()
    {
        this.m.ID = "effects.orc_young_potion";
		this.m.Name = "Improved Musculature";
		this.m.Icon = "skills/status_effect_127.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_127";
        this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
    }

    o.getDescription = function()
    {
        return "This character's muscles have mutated in such a way that they can easily lift things they had trouble with before.";
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
            }
        ];

        local is8 = this.getContainer().getActor().getFlags().has("orc_8");

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/melee_skill.png",
            text = "+" + ::MSU.Text.colorRed( is8 ? 20 : 10 ) + "% Damage"
        });
        ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "+" + ::MSU.Text.colorGreen( is8 ? 6 : 3 ) + " Fatigue Recovery"
		});
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "+" + ::MSU.Text.colorGreen( is8 ? 20 : 10 ) + " Hitpoints"
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
        local is8 = this.getContainer().getActor().getFlags().has("orc_8")
        _properties.DamageTotalMult *= is8 ? 1.20 : 1.10;
        _properties.FatigueRecoveryRate += is8 ? 6 : 3;
        _properties.Hitpoints += is8 ? 20 : 10;
    }

    o.onAdded <- function()
    {
        if (!this.m.Container.hasSkill("actives.charge"))
		{
			this.m.Container.add(::new("scripts/skills/actives/charge"));
		}
    }

    o.onRemoved <- function()
	{
		this.m.Container.removeByID("actives.charge");
	}

    o.onDismiss = function() {}
    o.onDeath = function( _fatalityType ) {}
});

//Add charge description
::mods_hookExactClass("skills/actives/charge", function (o)
{
    o.create = function()
	{
		this.m.ID = "actives.charge";
		this.m.Name = "Charge";
		this.m.Description = "Charge at the enemy, colliding and stunning them.";
		this.m.Icon = "skills/active_52.png";
		this.m.IconDisabled = "skills/active_52_sw.png";
		this.m.Overlay = "active_52";
		this.m.SoundOnUse = [
			"sounds/enemies/orc_charge_01.wav",
			"sounds/enemies/orc_charge_02.wav",
			"sounds/enemies/orc_charge_03.wav",
			"sounds/enemies/orc_charge_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/knockback_hit_01.wav",
			"sounds/combat/knockback_hit_02.wav",
			"sounds/combat/knockback_hit_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingActorPitch = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 40;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 1;
	}
});

::mods_hookExactClass("skills/perks/perk_ptr_cull", function (o)
{

    o.isEnabled = function()
	{
		if (this.m.IsForceEnabled || this.getContainer().getActor().getFlags().has("orc_8"))
		{
			return true;
		}

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(this.Const.Items.WeaponType.Axe))
		{
			return false;
		}

		return true;
	}
});