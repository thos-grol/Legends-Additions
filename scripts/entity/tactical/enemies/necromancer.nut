this.necromancer <- this.inherit("scripts/entity/tactical/human", {
	m = {
		School = "Body"
	},
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

		// this.m.Skills.add(this.new("scripts/skills/actives/raise_undead"));
		// this.m.Skills.add(this.new("scripts/skills/actives/possess_undead_skill"));

		//FEATURE_1: FEATURE necromancers - add magic spells based on school
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("ManInBlack", 1, 1);
		}

		///FEATURE_1: FEATURE necromancers - chance to drop magic tome based on school
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
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

