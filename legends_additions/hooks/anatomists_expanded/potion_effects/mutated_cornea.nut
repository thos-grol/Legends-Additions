//"Mutated Visual Cortex";
//"This character\'s eyes have been permanently mutated and are now capable of detecting the subtlest movements of wind and air. While minor on its own, this allows them to better predict the trajectory of projectile attacks and better land hits on vulnerable parts of a target.";

::mods_hookExactClass("skills/effects/goblin_overseer_potion_effect", function (o)
{
    o.create = function()
	{
		this.m.ID = "effects.goblin_overseer_potion";
		this.m.Name = "Mutated Visual Cortex";
		this.m.Icon = "skills/status_effect_126.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_126";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
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

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "An additional" + ::MSU.Text.colorGreen( "20" ) + "% of damage ignores armor when using bows or crossbows"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/ranged_skill.png",
            text = "+" + ::MSU.Text.colorGreen( "10" ) + " Ranged Skill"
        });
        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/initiative.png",
            text = "+" + ::MSU.Text.colorGreen( "15" ) + " Initiative"
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
        _properties.IsSharpshooter = true;
        _properties.RangedSkill += 10;
        _properties.Initiative += 15;
    }
});

// "[color=" + ::Const.UI.Color.NegativeValue + "][u]Requires:[/u] Bow[/color]\nRain down arrows upon your enemies from a higher angle, forcing them to divert their attention!\n\n[color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]\n• When using bows, every attack, hit or miss, applies a stacking debuff on the target reducing their Melee Skill and Ranged Skill by [color=" + ::Const.UI.Color.PositiveValue + "]-5[/color] and Melee Defense by [color=" + ::Const.UI.Color.PositiveValue + "]-3[/color] for one turn.\n• Enemies adjacent to the primary target receive half a stack.\n• Can have a maximum of [color=" + ::Const.UI.Color.PositiveValue + "]10[/color] stacks.";
::mods_hookExactClass("skills/perks/perk_ptr_eyes_up", function (o)
{
    o.isEnabled = function()
	{
		if (this.m.IsForceEnabled) return true;
        if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_overseer_potion")) return true;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			return false;
		}

		return true;
	}

});

//Modify Ranged Damage
::mods_hookExactClass("skills/actives/aimed_shot", function (o)
{
    o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= 1.1;

			if (_properties.IsSharpshooter)
			{
				_properties.DamageDirectMult += 0.20;
			}
		}
	}
});

::mods_hookExactClass("skills/actives/quick_shot", function (o)
{
    o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
    {
        if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (_properties.IsSharpshooter)
			{
				_properties.DamageDirectMult += 0.20;
			}
		}
    }
});

::mods_hookExactClass("skills/actives/shoot_bolt", function (o)
{
    o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
    {
        if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (_properties.IsSharpshooter)
			{
				_properties.DamageDirectMult += 0.20;
			}
		}
    }
});

//Stake Fixes
::mods_hookExactClass("skills/actives/shoot_stake", function (o)
{
    o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
    {
        if (_skill != this || _targetEntity == null) return;

		_properties.RangedSkill += this.m.AdditionalAccuracy;
		_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

		if (_targetEntity.getType() == ::Const.EntityType.Vampire || _targetEntity.getType() == ::Const.EntityType.LegendVampireLord)
		{
			//Shoot stake removes nine lives effect
            if (_targetEntity.getSkills().hasSkill("perk.nine_lives"))
            {
                local nine_lives = _targetEntity.getSkills().getSkillByID("perk.nine_lives");
                nine_lives.m.IsSpent = true;
            }

            _properties.DamageRegularMin += 100;
			_properties.DamageRegularMax += 105;
		}

		if (_properties.IsSharpshooter)
		{
			_properties.DamageDirectMult += 0.20;
		}

        //FEATURE_2: stake vampire players
    }
});

::mods_hookExactClass("skills/actives/legend_wooden_stake_stab", function (o)
{
    o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
    {
        if (_skill == this && _targetEntity != null)
		{
			if (_targetEntity.getType() == ::Const.EntityType.Vampire || _targetEntity.getType() == ::Const.EntityType.LegendVampireLord)
			{
				//stake removes nine lives effect
                if (_targetEntity.getSkills().hasSkill("perk.nine_lives"))
                {
                    local nine_lives = _targetEntity.getSkills().getSkillByID("perk.nine_lives");
                    nine_lives.m.IsSpent = true;
                }

                _properties.DamageRegularMin += 100;
				_properties.DamageRegularMax += 105;
			}
		}
    }
});

