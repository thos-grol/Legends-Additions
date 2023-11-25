this.swordmaster <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Swordmaster;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Swordmaster.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Swordmaster);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && !_skill.isRanged())
		{
			this.updateAchievement("ThereCanBeOnlyOne", 1, 1);
		}

		this.abstract_human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function pickOutfit()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"footman_armor"
				],
				[
					1,
					"leather_scale_armor"
				],
				[
					1,
					"light_scale_armor"
				]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					3,
					"nasal_helmet"
				],
				[
					2,
					"nasal_helmet_with_mail"
				],
				[
					2,
					"mail_coif"
				],
				[
					1,
					"feathered_hat"
				],
				[
					1,
					"headscarf"
				]
			]));
		}
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = this.Math.rand(1, 2);
		if (r == 1) //armor
		{
			local armor = [
				"armor/named/black_leather_armor",
				"armor/named/blue_studded_mail_armor"
			];

			if (this.Const.DLC.Wildmen)
			{
				armor.extend([
					"armor/named/named_noble_mail_armor"
				]);
			}
			this.m.Items.equip(this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(armor)));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

