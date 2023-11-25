this.master_archer <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.MasterArcher;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.MasterArcher.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}

		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MasterArcher);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && _skill.isRanged())
		{
			this.updateAchievement("Bullseye", 1, 1);
		}

		this.abstract_human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function post_init()
	{
		this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
	}

	function pickOutfit()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[
					1,
					"thick_tunic"
				],
				[
					1,
					"padded_surcoat"
				],
				[
					1,
					"leather_lamellar"
				],
				[
					1,
					"basic_mail_shirt"
				],
				[
					1,
					"ragged_surcoat"
				],
				[
					1,
					"basic_mail_shirt"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 50)
		{
			local helmet = [
				"helmets/hood",
				"helmets/headscarf"
			];
			this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
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
			this.m.Items.equip(this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(armor)));
		}
		else this.m.IsMinibossWeapon <- true;
	}


	function makeMiniboss()
	{
		this.actor.makeMiniboss();
		this.getSprite("miniboss").setBrush("bust_miniboss");
	}

});

