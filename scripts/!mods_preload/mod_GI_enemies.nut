local gt = this.getroottable();
gt.GI.hook_enemies <- function ()
{
    ::mods_hookExactClass("entity/tactical/enemies/lindwurm", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			this.m.Skills.add(this.new("scripts/skills/passives/dragons_might"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
			
		}
	});

	gt.Const.Tactical.Actor.Lindwurm = {
		XP = 800,
		ActionPoints = 7,
		Hitpoints = 1100,
		Bravery = 250,
		Stamina = 400,
		MeleeSkill = 80,
		RangedSkill = 0,
		MeleeDefense = 10,
		RangedDefense = -10,
		Initiative = 80,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		FatigueRecoveryRate = 30,
		Armor = [
			300,
			500
		]
	};

	::mods_hookExactClass("skills/racial/lindwurm_racial", function (o)
	{
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
				if (poison == null) target.getSkills().add(this.new("scripts/skills/effects/lindwurm_acid_effect"));
				else poison.resetTime();
				this.spawnIcon("status_effect_78", target.getTile());
			}
		}
	});
	
    ::mods_hookExactClass("entity/tactical/enemies/legend_stollwurm", function (o)
	{
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			this.m.Skills.add(this.new("scripts/skills/passives/dragons_might"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
		}
	});

    ::mods_hookExactClass("skills/perks/perk_overwhelm", function (o)
	{
		local onTargetHit = o.onTargetHit;
		o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
		{
			if (_skill.isRanged()) return;
			if (_targetEntity.getType() == this.Const.EntityType.Lindwurm || _targetEntity.getType() == this.Const.EntityType.LegendStollwurm) return;
			onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		}

		local onTargetMissed = o.onTargetMissed;
		o.onTargetMissed = function( _skill, _targetEntity )
		{
			if (_skill.isRanged()) return;
			if (_targetEntity.getType() == this.Const.EntityType.Lindwurm || _targetEntity.getType() == this.Const.EntityType.LegendStollwurm) return;
			onTargetMissed(_skill, _targetEntity);
		}
	});
};

gt.Const.World.Spawn.Troops.Lindwurm.Strength = 500;
gt.Const.World.Spawn.Troops.Lindwurm.Cost = 90;

gt.Const.World.Spawn.Troops.LegendStollwurm.Strength = 750;
gt.Const.World.Spawn.Troops.LegendStollwurm.Cost = 270;

gt.Const.World.Spawn.Lindwurm = {
	Name = "Lindwurm",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_lindwurm_01",
	MaxR = 500,
    Fixed = [
		{
			MaxCount = 1,
            Type = this.Const.World.Spawn.Troops.Lindwurm,
			Cost = 80,
			Weight = 0
		}
        //FEATURE_5: Add dragon minions?
	]
};

gt.Const.World.Spawn.LegendStollwurm = {
	Name = "LegendStollwurm",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.1,
	Body = "figure_stollwurm_01",
	MaxR = 500,
	Fixed = [
		{
			MaxCount = 1,
            Type = this.Const.World.Spawn.Troops.LegendStollwurm,
			Cost = 270,
			Weight = 0
		}
	]
    //FEATURE_5: Add dragon minions?
};

//Add anatomist and thug
gt.Const.EntityType.Anatomist <- 166;
gt.Const.Strings.EntityName.append("Anatomist");
gt.Const.EntityIcon.append("background_70");

gt.Const.World.Spawn.Troops.Anatomist <- {
	ID = this.Const.EntityType.Anatomist,
	Variant = 1,
	Strength = 25,
	Cost = 20,
	Row = 3,
	Script = "scripts/entity/tactical/enemies/anatomist",
	NameList = this.Const.Strings.NecromancerNames,
	TitleList = null
};

gt.Const.World.Spawn.Troops.BanditThugPotioned <- {
	ID = this.Const.EntityType.BanditThug,
	Variant = 0,
	Strength = 16,
	Cost = 11,
	Row = 3,
	Script = "scripts/entity/tactical/enemies/bandit_thug_potioned"
};