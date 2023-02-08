//"Acidic blood";
//"This character\'s blood is highly pressurized and burns upon prolonged exposure to air. Attackers who break skin will find themselves unpleasantly surprised by the resultant spray.";
::mods_hookExactClass("skills/effects/lindwurm_potion_effect", function (o)
{
    o.create = function()
	{
		this.m.ID = "effects.lindwurm_potion";
		this.m.Name = "Acidic blood";
		this.m.Icon = "skills/status_effect_140.png";
		this.m.IconMini = "status_effect_140_mini";
		this.m.Overlay = "status_effect_140";
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
            text = "This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage"
        });

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "+" + ::MSU.Text.colorGreen( "30" ) + " Hitpoints"
        });

        ret.push({
            id = 12,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
        });

        return ret;
    }

    o.onUpdate <- function(_properties)
    {
        _properties.Hitpoints += 30;
    }

    o.onDamageReceived = function(_attacker, _damageHitpoints, _damageArmor)
    {
        if (_damageHitpoints <= 5) return;
        local _actor = this.getContainer().getActor();
        local targets = [_attacker];

        if (_damageHitpoints >= 50)
        {
            targets = [];
            local mytile = _tag.User.getTile();
            local actors = this.Tactical.Entities.getAllInstances();

            foreach( i in actors )
            {
                foreach( a in i )
                {
                    if (a.getID() != _actor.getID() && a.getTile().getDistanceTo(mytile) < 3) targets.append(a);
                }
            }

        }

        foreach(target in targets)
        {
            if (target == null || !target.isAlive()) continue;
            if (target.getTile().getDistanceTo(_actor.getTile()) >= 3) continue;
            if (target.getFlags().has("lindwurm")) continue;
            if (target.getFlags().has("body_immune_to_acid") && target.getFlags().has("head_immune_to_acid")) continue;

            local poison = target.getSkills().getSkillByID("effects.lindwurm_acid");
            if (poison == null) target.getSkills().add(::new("scripts/skills/effects/lindwurm_acid_effect"));
            else poison.resetTime();
            this.spawnIcon("status_effect_78", target.getTile());
        }
    }
});