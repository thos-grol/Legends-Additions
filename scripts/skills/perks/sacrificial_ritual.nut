
this.sacrificial_ritual <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "perk.sacrificial_ritual";
		this.m.Name = ::Const.Strings.PerkName.SacrificialRitual;
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Icon = "ui/perks/sacrificial_ritual.png";
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local resp = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = "The first ritual any cultist learns. The souls harvested by this brother will belong to Davkul. Davkul will reward the devotee after getting 4, 44, 66 kills at their discretion."
			}
		];

		resp.push({
			id = 15,
			type = "hint",
			icon = "ui/icons/special.png",
			text = actor.getFlags().getAsInt("SoulsHarvestedForDavkul") + " souls harvested for Davkul"
		});

		resp.push({
			id = 15,
			type = "hint",
			icon = "ui/icons/special.png",
			text = "Reward for 4 souls: " + actor.getFlags().get("Davkul1stReward")
		});

		resp.push({
			id = 15,
			type = "hint",
			icon = "ui/icons/special.png",
			text = "Reward for 44 souls: " + actor.getFlags().get("Davkul2ndReward")
		});

		resp.push({
			id = 15,
			type = "hint",
			icon = "ui/icons/special.png",
			text = "Reward for 66 souls: " + actor.getFlags().get("Davkul3rdReward")
		});


		return resp;
	}

	function getTotalKillStats()
	{
		return ::Const.LegendMod.GetFavoriteEnemyStats(this.getContainer().getActor(), this.m.ValidTypes);
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("SoulsHarvestedForDavkul")) actor.getFlags().add("SoulsHarvestedForDavkul", 0);
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
        actor.getFlags().increment("SoulsHarvestedForDavkul", 1);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Davkul1stRewarded") && actor.getFlags().getAsInt("SoulsHarvestedForDavkul") >= 4)
			addReward("Davkul1stReward");
		if (!actor.getFlags().has("Davkul2ndRewarded") && actor.getFlags().getAsInt("SoulsHarvestedForDavkul") >= 44)
			addReward("Davkul2ndReward");
		if (!actor.getFlags().has("Davkul3rdRewarded") && actor.getFlags().getAsInt("SoulsHarvestedForDavkul") >= 66)
			addReward("Davkul3rdReward");
	}
		
	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlayerControlled()) return;
		if (actor.getFlags().has("Davkul1stReward")) return;
		
		local roll;
		foreach (rewardtier in ::Const.PerkInfo.SacrificialRitual.Rewards) 
		{
			::logInfo("Doing " + rewardtier.ID);
			roll = this.Math.rand(1, 100);
			foreach (reward in rewardtier.Rolls) 
			{
				::logInfo("Checking " + reward.ID);
				if (reward.Validator.len() != 0) //If has validator(s), run it.
				{
					::logInfo("Has validator, checking...");
					local valid = true;
					foreach (index, validator in reward.Validator) 
					{
						local check = validator(actor, reward.Params[index]);
						::logInfo("Validator[" + index + "] returns " + check);
						if (!check) //if validator returns false
						{
							valid = false;
							break;
						}
					}
					if (!valid) continue;
				}
				
				::logInfo("Rolling " + roll + " vs " + reward.Chance);
				if (roll <= reward.Chance) //Since it's valid, then roll
				{
					::logInfo("Adding to " + rewardtier.ID + ", " + reward.ID);
					actor.getFlags().add(rewardtier.ID, reward.ID);
					break;
				}
			}
		}
	}

	function addReward( str )
	{
		local actor = this.getContainer().getActor();
		local reward_id = actor.getFlags().get(str);
		this.logInfo(str + "ed");
		this.logInfo(reward_id);

		if (reward_id in ::Const.PerkInfo.SacrificialRitual.RewardTable)
		{
			local reward = ::Const.PerkInfo.SacrificialRitual.RewardTable[reward_id];

			foreach (index, fn in reward.functions) 
			{
				fn(actor, reward.params);
			}
			actor.getFlags().set(str + "ed", true);

		}
	}

});



::Const.PerkInfo <- {};
::Const.PerkInfo.SacrificialRitual <- {};

//Helper fns

::Const.PerkInfo.SacrificialRitual.hasReward <- function(actor, params)
{
	return actor.getFlags().get("Davkul1stReward") == params[0]
		|| actor.getFlags().get("Davkul2ndReward") == params[0]
		|| actor.getFlags().get("Davkul3rdReward") == params[0];
}

::Const.PerkInfo.SacrificialRitual.hasRewardNot <- function(actor, params)
{
	return !::Const.PerkInfo.SacrificialRitual.hasReward(actor, params);
}

::Const.PerkInfo.SacrificialRitual.hasSkill <- function(actor, params)
{
	return actor.getSkills().hasSkill(params[0]);
}

::Const.PerkInfo.SacrificialRitual.hasSkillNot <- function(actor, params)
{
	return !::Const.PerkInfo.SacrificialRitual.hasSkill(actor, params);
}

::Const.PerkInfo.SacrificialRitual.canLucky <- function(actor, params)
{
	return !actor.getSkills().hasSkill(params[0]) || actor.getFlags().getAsInt("Lucky") < 9;
}

::Const.PerkInfo.SacrificialRitual.addFlag <- function(actor, params)
{
	actor.getFlags().add(params[0], params[1]);
}

::Const.PerkInfo.SacrificialRitual.addPerk <- function(actor, params)
{
	::LA.addPerk(actor, params[0], params[1]);
}

::Const.PerkInfo.SacrificialRitual.lucky <- function(actor, params)
{
	if(actor.getSkills().hasSkill("trait.lucky"))
	{
		local lucky = actor.getSkills().getSkillByID("trait.lucky");
		lucky.boostLuck();
	}
	else actor.getSkills().add(::new("scripts/skills/traits/natural_trait"));
}

//Tables

::Const.PerkInfo.SacrificialRitual.Rewards <- [
	{
		ID = "Davkul1stReward",
		Rolls = [
			{
				ID = "Eldritch Blast",
				Validator = [],
				Params = [],
				Chance = 10
			},
			{
				ID = "Pain Ritual",
				Validator = [],
				Params = [],
				Chance = 45
			},
			{
				ID = "Lacerate",
				Validator = [],
				Params = [],
				Chance = 100
			}
		]
	},
	{
		ID = "Davkul2ndReward",
		Rolls = [
			{
				ID = "Agonizing Blast",
				Validator = [
					::Const.PerkInfo.SacrificialRitual.hasReward
				], 
				Params = [
					["Eldritch Blast"]
				],
				Chance = 75
			},
			{
				ID = "Eyes on the Inside",
				Validator = [
					::Const.PerkInfo.SacrificialRitual.hasSkillNot
				],
				Params = [
					["perk.eyes_on_the_inside"]
				],
				Chance = 20
			},
			{
				ID = "Spirit Vessel",
				Validator = [],
				Params = [],
				Chance = 35
			},
			{
				ID = "Writhing Flesh",
				Validator = [],
				Params = [],
				Chance = 100
			}
		]
	},
	{
		ID = "Davkul3rdReward",
		Rolls = [
			{
				ID = "Instinctive Blast",
				Validator = [
					::Const.PerkInfo.SacrificialRitual.hasReward
				], 
				Params = [
					["Eldritch Blast"]
				],
				Chance = 100
			},
			{
				ID = "Eyes on the Inside",
				Validator = [
					::Const.PerkInfo.SacrificialRitual.hasSkillNot,
					::Const.PerkInfo.SacrificialRitual.hasRewardNot
				],
				Params = [
					["perk.eyes_on_the_inside"],
					["Eyes on the Inside"]
				],
				Chance = 20
			},
			{
				ID = "Spirit Vessel",
				Validator = [
					::Const.PerkInfo.SacrificialRitual.hasRewardNot
				],
				Params = [
					["Spirit Vessel"]
				],
				Chance = 35
			},
			{
				ID = "Perfect Spirit Vessel",
				Validator = [
					::Const.PerkInfo.SacrificialRitual.hasReward
				],
				Params = [
					["Spirit Vessel"]
				],
				Chance = 35
			},
			{
				ID = "Writhing Flesh",
				Validator = [
					::Const.PerkInfo.SacrificialRitual.hasRewardNot
				],
				Params = [
					["Writhing Flesh"]
				],
				Chance = 60
			},
			{
				ID = "Compassion Ritual",
				Validator = [],
				Params = [],
				Chance = 100
			}
		]
	}
];



::Const.PerkInfo.SacrificialRitual.RewardTable <- {
	//TIer 1
	"Eldritch Blast" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addPerk
		],
		"params" : [::Const.Perks.PerkDefs.EldritchBlast, 2]
	},
	"Pain Ritual" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addPerk
		],
		"params" : [::Const.Perks.PerkDefs.PainRitual, 2]
	},
	"Lacerate" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addPerk
		],
		"params" : [::Const.Perks.PerkDefs.LegendLacerate, 2]
	},

	//Tier 2
	"Agonizing Blast" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addFlag
		],
		"params" : ["AgonizingBlast", true]
	},
	"Brink of Death" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addPerk
		],
		"params" : [::Const.Perks.PerkDefs.LegendBrinkOfDeath, 3]
	},
	"Eyes on the Inside" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addPerk
		],
		"params" : [::Const.Perks.PerkDefs.EyesOnTheInside, 3]
	},
	"Spirit Vessel" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addPerk
		],
		"params" : [::Const.Perks.PerkDefs.SpiritVessel, 3]
	},
	"Writhing Flesh" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addPerk
		],
		"params" : [::Const.Perks.PerkDefs.WrithingFlesh, 3]
	},

	//Tier 3
	"Instinctive Blast" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addFlag
		],
		"params" : ["InstinctiveBlast", true]
	},
	"Perfect Spirit Vessel" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addFlag
		],
		"params" : ["PerfectSpiritVessel", true]
	},
	"Compassion Ritual" : {
		"functions" : [
			::Const.PerkInfo.SacrificialRitual.addPerk
		],
		"params" : [::Const.Perks.PerkDefs.CompassionRitual, 4]
	}
		
};