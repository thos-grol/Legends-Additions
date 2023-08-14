//"Subdermal Reactivity";
//"It\'s just a flesh wound! This character\'s subdermal flesh has mutated and automatically reacts to sudden trauma, lessening the chance to suffer injuries in battle.";
::mods_hookExactClass("skills/effects/wiederganger_potion_effect", function (o)
{
    o.create = function()
	{
		this.m.ID = "effects.wiederganger_potion";
		this.m.Name = "Subdermal Reactivity";
		this.m.Icon = "skills/status_effect_135.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_135";
        this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
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
            text = "The threshold to sustain injuries on getting hit is increased by" + ::MSU.Text.colorGreen( "33" ) + "%"
        });

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Reduces damage taken by" + ::MSU.Text.colorGreen( "15" ) + "%"
        });

        ret.push({
            id = 12,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
        });
        return ret;
    }

    o.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		_properties.DamageReceivedRegularMult *= 1.0 - 0.15;
	}

    o.onUpdate = function(_properties)
    {
        _properties.ThresholdToReceiveInjuryMult *= 1.33;
    }
});