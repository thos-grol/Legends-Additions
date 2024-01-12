this.barbarian_chosen <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.BarbarianChosen;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BarbarianChosen.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.WildMale;
		this.m.Hairs = ::Const.Hair.WildMale;
		this.m.HairColors = ::Const.HairColors.Old;
		this.m.Beards = ::Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (::Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (::Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BarbarianChosen);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("KingOfTheNorth", 1, 1);
		}
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function pickOutfit()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local armor = [
				[
					1,
					"barbarians/thick_plated_barbarian_armor"
				],
				[
					1,
					"barbarians/reinforced_heavy_iron_armor"
				]
			];
			local helmet = [
				[
					1,
					"barbarians/heavy_horned_plate_helmet"
				],
				[
					1,
					"barbarian_chosen_helmet_00"
				],
				[
					1,
					"barbarian_chosen_helmet_01"
				],
				[
					1,
					"barbarian_chosen_helmet_02"
				]
			];
			local outfits = [
				[
					1,
					"barbarian_chosen_outfit_00"
				],
				[
					1,
					"barbarian_chosen_outfit_01"
				],
				[
					1,
					"barbarian_chosen_outfit_02"
				]
			];

			foreach( item in ::Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}

			return;
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = [
				[
					1,
					"barbarians/thick_plated_barbarian_armor"
				]
			];
			armor.push([
				1,
				"barbarians/reinforced_heavy_iron_armor"
			]);
			armor.push([
				1,
				"barbarian_chosen_armor_00"
			]);
			armor.push([
				1,
				"barbarian_chosen_armor_01"
			]);
			this.m.Items.equip(::Const.World.Common.pickArmor(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = [
				[
					1,
					"barbarians/heavy_horned_plate_helmet"
				],
				[
					1,
					"barbarian_chosen_helmet_00"
				],
				[
					1,
					"barbarian_chosen_helmet_01"
				],
				[
					1,
					"barbarian_chosen_helmet_02"
				]
			];
			this.m.Items.equip(::Const.World.Common.pickHelmet(helmet));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

