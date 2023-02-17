this.spirit_vessel <- this.inherit("scripts/skills/skill", {
	m = {
		chance = 0,
		isCombat = false
	},
	function create()
	{
		this.m.ID = "perk.spirit_vessel";
		this.m.Name = ::Const.Strings.PerkName.SpiritVessel;
		this.m.Description = ::Const.Strings.PerkDescription.SpiritVessel;
		this.m.Icon = "ui/perks/spirit_vessel.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = "Not all doors are wounds, but all wounds are doors..."
			}
		];

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a " + ::MSU.Text.colorRed( (this.m.isCombat ? this.m.chance : 13 + getInjuryBonus()) ) + "% chance to summon spirits."
		});

		if (actor.getFlags().has("PerfectSpiritVessel"))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Perfect Spirit Vessel: Increases the chances of summoning stronger spirits"
			});
		}
		return ret;
	}

	function onTurnEnd()
	{
		if (this.Math.rand(1, 100) <= this.m.chance) summon();
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.Math.rand(1, 100) <= this.m.chance) summon();
	}

	function onCombatStarted()
	{
		this.m.chance = 13 + getInjuryBonus();
		this.m.isCombat = true;
	}

	function onCombatFinished()
	{
		this.m.chance = 13 + getInjuryBonus();
		this.m.isCombat = false;
	}

	function summon()
	{
		local actor = this.getContainer().getActor();
		local candidates = [];
		local myTile = actor.getTile();

		local summons = [
			"scripts/entity/tactical/enemies/ghost"
		];

		if (actor.getFlags().has("PerfectSpiritVessel") || this.Math.rand(1, 100) <= 44) summons.push("scripts/entity/tactical/enemies/legend_demon_hound");
		if (actor.getFlags().has("PerfectSpiritVessel") && this.Math.rand(1, 100) <= 44) summons.push("scripts/entity/tactical/enemies/legend_banshee");
		
		for( local i = 0; i < 6; i = i )
		{
			if (!myTile.hasNextTile(i)){}
			else
			{
				local nextTile = myTile.getNextTile(i);

				if (nextTile.IsEmpty && this.Math.abs(myTile.Level - nextTile.Level) <= 1)
				{
					candidates.push(nextTile);
				}
			}
			i = ++i;
		}

		if (candidates.len() != 0)
		{
			local spawnTile = candidates[this.Math.rand(0, candidates.len() - 1)];
			local sapling = this.Tactical.spawnEntity(::MSU.Array.rand(summons), spawnTile.Coords);
			sapling.setFaction(actor.getFaction() == ::Const.Faction.Player ? ::Const.Faction.PlayerAnimals : actor.getFaction());
			sapling.riseFromGround();
		}
		this.Sound.play("sounds/cultist/spirit_vessel.wav", 200.0, actor.getPos(), this.Math.rand(95, 105) * 0.01);
		this.m.chance -= 1;
	}

	function getInjuryBonus()
	{
		local actor = this.getContainer().getActor();
        local skills = actor.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);
		local count = 0;
        foreach( s in skills )
        {
            if (s.isType(::Const.SkillType.PermanentInjury)) count += 1;
        }
		return count * 4;
        
	}

	function onUpdate( _properties )
	{
		_properties.HitpointsMult *= 0.56;
		_properties.InitiativeMult *= 0.56;
		_properties.StaminaMult *= 0.56;
	}

	

});

