this.necromancer <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Name = "Necromancer (Apprentice)"
		this.m.Type = this.Const.EntityType.Necromancer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Necromancer.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.Necromancer;
		this.m.Hairs = this.Const.Hair.Necromancer;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.ConfidentMoraleBrush = "icon_confident_undead";
		this.m.SoundPitch = 0.9;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/necromancer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Necromancer);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_undead");
		this.getSprite("head").Color = this.createColor("#ffffff");
		this.getSprite("head").Saturation = 1.0;
		this.getSprite("body").Saturation = 0.6;

		this.m.Skills.add(this.new("scripts/skills/perks/perk_class_winter_mage"));
		local mana_pool = this.m.Skills.getSkillByID("trait.mana_pool");
		mana_pool.upgrade(40);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
			this.updateAchievement("ManInBlack", 1, 1);
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function drop_loot(_tile)
	{
		if (::Math.rand(1,100) <= 25 )
		{
			local tome = this.new("scripts/items/misc/tome");
			tome.set_tome(this.m.Build.Drop);
			tome.drop(_tile);
		}

		for(local i = 0; i < 3; i++ )
		{
			if (::Math.rand(1,100) <= 20 )
			{
				local s = this.new("scripts/items/misc/magic/soul_splinter");
				s.drop(_tile);
			}
		}

	}

	function pickOutfit()
	{
		local item = this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_dark_surcoat"
			],
			[
				1,
				"thick_dark_tunic"
			]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"witchhunter_hat"
			],
			[
				1,
				"dark_cowl"
			],
			[
				1,
				"hood",
				63
			]
		]);
		this.m.Items.equip(item);
	}

	function pickNamed()
	{
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"named/witchhunter_helm"
			]
		]);
		this.m.Items.equip(item);
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

