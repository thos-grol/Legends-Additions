::Const.Strings.PerkName.StanceWrath <- "Wrath";
::Const.Strings.PerkDescription.StanceWrath <- ::MSU.Text.color(::Z.Color.Purple, "Stance")
+ "\nSacrifice defense to gain the ultimate offense"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("+25%") + " damage"
+ "\n"+::MSU.Text.colorRed("– 25%") + " Melee Defense"
+ "\n"+::MSU.Text.colorRed("– 25%") + " Fatigue cost for AOE attacks"
+ "\n"+::MSU.Text.colorGreen("– 2") + " AP cost for AOE attacks";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceWrath].Name = ::Const.Strings.PerkName.StanceWrath;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceWrath].Tooltip = ::Const.Strings.PerkDescription.StanceWrath;

this.perk_stance_wrath <- this.inherit("scripts/skills/skill", {
	m = {
		Active = false,
		Skills = [
			"actives.legend_chain_thresh",
			"actives.reap",
			"actives.round_swing",
			"actives.shatter",
			"actives.split_axe",
			"actives.split",
			"actives.ghost_split",
			"actives.swing",
			"actives.ghost_swing",
			"actives.thresh"
		]
	},
	function create()
	{
		this.m.ID = "perk.stance.wrath";
		this.m.Name = ::Const.Strings.PerkName.StanceWrath;
		this.m.Description = ::Const.Strings.PerkDescription.StanceWrath;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.25;
		_properties.MeleeDefenseMult *= 0.75;
	}

	function onAfterUpdate(_properties)
	{
		if (!this.getContainer().getActor().isPlacedOnMap()) return;
		local skills = this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this));

		if (skills.len() == 0) return;
		foreach (s in skills)
		{
			if (s != null)
			{
				s.m.ActionPointCost -= 2;
				s.m.FatigueCostMult *= 0.75;
			}
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		if (_skill != null)
		{
			foreach (skill in this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this)))
			{
				this.modifyPreviewField(skill, "ActionPointCost", skill.m.ActionPointCost - 2, false);
				this.modifyPreviewField(skill, "FatigueCostMult", 0.75, true);
			}
		}
	}

});

